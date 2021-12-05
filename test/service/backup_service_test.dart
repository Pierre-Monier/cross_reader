import 'dart:io';

import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:file/memory.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/mock_class.dart';
import '../utils/mock_data.dart';

final cacheDirPath = Directory.current.path;
final backupDirPath = cacheDirPath + '/backup/';
final mangasJsonFile = backupDirPath + 'mangas.json';

void main() {
  setUpAll(() {
    final mockBoxService = MockBoxService();
    GetIt.I.registerSingleton<BoxService>(mockBoxService);
    when(() => mockBoxService.getAllMangas())
        .thenAnswer((_) => Future.value([mockManga]));
    GetIt.I.registerSingleton<ChapterRepository>(ChapterRepository());
  });
  test('It should create backup dir with a file named mangas.json inside',
      () async {
    final backupService =
        BackupService(Directory(cacheDirPath), fileSystem: MemoryFileSystem());
    final backupFiles = await backupService.getBackupFiles();

    final backupDirPath = '$cacheDirPath/${BackupService.backupDirName}';
    final mangasJsonFilePath =
        '$backupDirPath/${BackupService.mangasJsonFileName}';

    expect(backupFiles.backupDirectory.path, backupDirPath);
    expect(backupFiles.mangasJsonFile.path, mangasJsonFilePath);
    expect(backupFiles.backupDirectory.existsSync(), true);
    expect(backupFiles.mangasJsonFile.existsSync(), true);
  });

  test('It should transform all images path to match the backup directory',
      () async {
    final mangas = await GetIt.I.get<BoxService>().getAllMangas();
    final backupService =
        BackupService(Directory(cacheDirPath), fileSystem: MemoryFileSystem());
    final backupFiles = await backupService.getBackupFiles();
    final mutatedMangas = backupService.createBackupMangas(backupFiles, mangas);

    final newDirPath = '$backupDirPath/${mangas[0].name}/';

    expect(
        mutatedMangas[0].chapters[0].imagesPath[0] !=
            mangas[0].chapters[0].imagesPath[0],
        true);
    expect(mutatedMangas[0].chapters[0].imagesPath[0],
        '$newDirPath/${mangas[0].chapters[0].name}/${mangas[0].chapters[0].imagesPath[0]}');
  }, skip: true);

  test('It should copy all mangas images to backupDir', () async {
    final mangas = await GetIt.I.get<BoxService>().getAllMangas();
    final backupService =
        BackupService(Directory(cacheDirPath), fileSystem: MemoryFileSystem());
    final backupFiles = await backupService.getBackupFiles();
    final backupMangas = backupService.createBackupMangas(backupFiles, mangas);
    await backupService.copyMangasFiles(backupMangas);

    final mangaDir = Directory('$backupDirPath/${backupMangas[0].name}');
    final chapterDir = Directory('$backupDirPath/${backupMangas[0].name}');
    final imageFile = File(backupMangas[0].chapters[0].imagesPath[0]);

    expect(mangaDir.existsSync(), true);
    expect(chapterDir.existsSync(), true);
    expect(imageFile.existsSync(), true);
  });
}
