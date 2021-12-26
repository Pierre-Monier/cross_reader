import 'dart:io';

import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/archive_service.dart';
import 'package:cross_reader/service/file_helper.dart';
import 'package:file/local.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:file/file.dart' show FileSystem;

class BackupService {
  final Directory _cacheDirectory;
  final FileSystem fileSystem;
  const BackupService(this._cacheDirectory,
      {this.fileSystem = const LocalFileSystem()});

  static const backupDirName = "backup";
  static const mangasJsonFileName = 'mangas.json';

  /// return a list of manga that failed to backup
  ///
  /// If null is return that means that the backup operation as failed
  Future<BackupResponse> backup() async {
    try {
      final backupDir = await createBackupDir();
      final mangas = await GetIt.I.get<MangaRepository>().mangaList;
      final backupResponse =
          await copyMangas(backupDir: backupDir, onDeviceManga: mangas);
      return backupResponse;
    } catch (e) {
      debugPrint("Backup failed: $e");
      rethrow;
    }
  }

  Future<Directory> createBackupDir() {
    final backupDirectoryPath = FileHelper.createPath(
        [_cacheDirectory.path, backupDirName],
        isDirectory: true);
    final backupDirectory = fileSystem.directory(backupDirectoryPath);

    return backupDirectory.create(recursive: true);
  }

  /// return a list of all mangas that failed to backup
  Future<BackupResponse> copyMangas(
      {required Directory backupDir,
      required List<Manga> onDeviceManga}) async {
    final fails = <Manga>[];
    // loop on each manga
    // copy manga directory to backup directory
    for (final manga in onDeviceManga) {
      final mangaDir = fileSystem.directory(manga.onDevicePath);
      try {
        final archiveFilePath = FileHelper.createPath(
            [backupDir.path, manga.name],
            isArchive: true);
        final archiveFile = fileSystem.file(archiveFilePath);
        await GetIt.I.get<ArchiveService>().compressDirToArchive(
            directory: mangaDir, archiveFile: archiveFile);
      } catch (e) {
        debugPrint("manga ${manga.name} directory copy failed ${e.toString()}");
        fails.add(manga);
      }
    }

    final archiveBackupDirPath =
        FileHelper.createPath([backupDir.path, '.zip'], isArchive: true);
    final archiveBackupDir = fileSystem.file(archiveBackupDirPath);

    return BackupResponse(fails: fails, archiveBackupDir: archiveBackupDir);
  }
}

class BackupResponse {
  final List<Manga> fails;
  final File archiveBackupDir;
  BackupResponse({required this.fails, required this.archiveBackupDir});
}
