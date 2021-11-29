import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:get_it/get_it.dart';

class BackupService {
  final Directory _cacheDirectory;
  final bool shouldMock;
  const BackupService(this._cacheDirectory, {this.shouldMock = false});

  static const backupDirName = 'backup/';
  static const mangasJsonFileName = 'mangas.json';

  Future<BackupFiles> getBackupFiles() async {
    final backupDirectory = Directory('${_cacheDirectory.path}/$backupDirName');
    final mangasJsonFile = File('${backupDirectory.path}/$mangasJsonFileName');

    if (!shouldMock) {
      await backupDirectory.create();
      await mangasJsonFile.create();
    }

    return BackupFiles(backupDirectory, mangasJsonFile);
  }

  List<Manga> transformImagesPath(BackupFiles backupFiles, List<Manga> mangas) {
    return mangas.map((manga) {
      final newDirPath = '${backupFiles.backupDirectory.path}/${manga.name}/';
      final List<Chapter> chapters = GetIt.I
          .get<ChapterRepository>()
          .transformImagesPath(newDirPath, manga.chapters);

      return Manga(manga.name, chapters);
    }).toList();
  }
}

class BackupFiles {
  final Directory _backupDirectory;
  final File _mangasJsonFile;

  const BackupFiles(this._backupDirectory, this._mangasJsonFile);

  File get mangasJsonFile => _mangasJsonFile;
  Directory get backupDirectory => _backupDirectory;
}
