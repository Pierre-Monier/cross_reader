import 'dart:io';

import 'package:cross_reader/service/backup_service.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/mock_class.dart';
import '../utils/mock_data.dart';

const cacheDirPath = '/tmpPath/';
const backupDirPath = cacheDirPath + 'backup/';
const mangasJsonFile = backupDirPath + 'mangas.json';

void main() {
  test('It should create backup dir with a file named mangas.json inside',
      () async {
    final backupService =
        BackupService(Directory(cacheDirPath), shouldMock: true);
    final backupFiles = await backupService.getBackupFiles();

    final backupDirPath = '$cacheDirPath/${BackupService.backupDirName}';
    final mangasJsonFilePath =
        '$backupDirPath/${BackupService.mangasJsonFileName}';

    expect(backupFiles.backupDirectory.path, backupDirPath);
    expect(backupFiles.mangasJsonFile.path, mangasJsonFilePath);
  });

  test('It should get all mangas from the app', () async {
    final backupService =
        BackupService(Directory(cacheDirPath), shouldMock: true);
    final mangas = await backupService.getMangas();

    expect(mangas, [mockManga]);
  }, skip: true);
}
