import "dart:io";

import "package:cross_reader/model/manga.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:cross_reader/service/archive_service.dart";
import "package:cross_reader/service/file_helper.dart";
import "package:file/file.dart" show FileSystem;
import "package:file/local.dart";
import "package:flutter/foundation.dart";
import "package:get_it/get_it.dart";

/// Service to handle backups
class BackupService {
  /// Service to handle backups
  const BackupService(
    this._cacheDirectory, {
    FileSystem fileSystem = const LocalFileSystem(),
  }) : _fileSystem = fileSystem;
  final Directory _cacheDirectory;
  final FileSystem _fileSystem;

  /// the backup directory name
  static const backupDirName = "backup";

  /// return a list of manga that failed to backup
  ///
  /// If null is return that means that the backup operation as failed
  Future<BackupResponse> backup() async {
    try {
      final backupDir = await _createBackupDir();
      final mangas = await GetIt.I.get<MangaRepository>().mangaList;

      final backupResponse =
          await copyMangas(backupDir: backupDir, onDeviceManga: mangas);

      return backupResponse;
    } catch (e) {
      debugPrint("Backup failed: $e");
      rethrow;
    }
  }

  Future<Directory> _createBackupDir() {
    final backupDirectoryPath = FileHelper.createPath(
      [_cacheDirectory.path, backupDirName],
      isDirectory: true,
    );
    final backupDirectory = _fileSystem.directory(backupDirectoryPath);

    return backupDirectory.create(recursive: true);
  }

  /// return a list of all mangas that failed to backup
  Future<BackupResponse> copyMangas({
    required Directory backupDir,
    required List<Manga> onDeviceManga,
  }) async {
    final tmpMangaDirPath = FileHelper.createPath(
      [backupDir.path, "tmp"],
      isDirectory: true,
    );
    final tmpMangaDir =
        await _fileSystem.directory(tmpMangaDirPath).create(recursive: true);

    final fails = <Manga>[];
    // loop on each manga
    // copy manga directory to backup directory
    for (final manga in onDeviceManga) {
      final mangaDir = _fileSystem.directory(manga.onDevicePath);
      try {
        final mangaArchiveFilePath = FileHelper.createPath(
          [tmpMangaDir.path, manga.name],
          isArchive: true,
        );

        final mangaArchiveFile = _fileSystem.file(mangaArchiveFilePath);

        await GetIt.I.get<ArchiveService>().compressDirToArchive(
              directory: mangaDir,
              archiveFile: mangaArchiveFile,
            );
      } catch (e) {
        debugPrint("manga ${manga.name} directory copy failed ${e.toString()}");
        fails.add(manga);
      }
    }

    final archiveBackupFilePath = FileHelper.createPath(
      [backupDir.path, "cross_reader_backup"],
      isArchive: true,
    );
    final archiveBackupFile = _fileSystem.file(archiveBackupFilePath);

    await GetIt.I.get<ArchiveService>().compressDirToArchive(
          directory: tmpMangaDir,
          archiveFile: archiveBackupFile,
        );

    return BackupResponse(fails: fails, archiveBackupDir: archiveBackupFile);
  }
}

/// response model of a backup operation
class BackupResponse {
  /// response model of a backup operation
  BackupResponse({required this.fails, required this.archiveBackupDir});

  /// list of `Manga` that fails to backup
  final List<Manga> fails;

  /// the backup archive file
  final File archiveBackupDir;
}
