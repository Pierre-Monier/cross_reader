import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:file/local.dart';
import 'package:get_it/get_it.dart';
import 'package:file/file.dart' show FileSystem;

class BackupService {
  final Directory _cacheDirectory;
  final FileSystem fileSystem;
  const BackupService(this._cacheDirectory,
      {this.fileSystem = const LocalFileSystem()});

  static const backupDirName = 'backup/';
  static const mangasJsonFileName = 'mangas.json';

  Future<BackupFiles> getBackupFiles() async {
    final backupDirectory =
        fileSystem.directory('${_cacheDirectory.path}/$backupDirName');
    final mangasJsonFile =
        fileSystem.file('${backupDirectory.path}/$mangasJsonFileName');

    // if (!shouldMock) {
    await backupDirectory.create(recursive: true);
    await mangasJsonFile.create(recursive: true);
    // }

    return BackupFiles(backupDirectory, mangasJsonFile);
  }

  List<Manga> createBackupMangas(BackupFiles backupFiles, List<Manga> mangas) {
    return mangas.map((manga) {
      final newDirPath = '${backupFiles.backupDirectory.path}/${manga.name}/';
      final List<Chapter> chapters = GetIt.I
          .get<ChapterRepository>()
          .transformImagesPath(newDirPath, manga.chapters);

      return Manga(manga.name, chapters);
    }).toList();
  }

  Future<bool> copyMangasFiles(List<Manga> mangas) async {
    try {
      final backupImagesPath = [];
      final onDeviceImagesPath = [];

      if (backupImagesPath.length == onDeviceImagesPath.length) {
        // length of arrays
        final length = backupImagesPath.length;

        for (var i = 0; i < length; i++) {
          final onDeviceFile = fileSystem.file(onDeviceImagesPath[i]);
          final file = fileSystem.file(backupImagesPath[i]);

          await file.create(recursive: true);
          await onDeviceFile.copy(file.path);
        }

        return true;
      } else {
        throw Exception(
            'Backup files and on device files doesn\'t have the same size');
      }
    } catch (e) {
      return false;
    }
  }
}

class BackupFiles {
  final Directory _backupDirectory;
  final File _mangasJsonFile;

  const BackupFiles(this._backupDirectory, this._mangasJsonFile);

  File get mangasJsonFile => _mangasJsonFile;
  Directory get backupDirectory => _backupDirectory;
}
