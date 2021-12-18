import 'dart:io';

import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:cross_reader/service/file_helper.dart';
import 'package:file/memory.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/mock_class.dart';
import '../utils/mock_data.dart';

final cacheDirPath = Directory.current.path;
final backupDirPath = FileHelper.createPath(
    [cacheDirPath, BackupService.backupDirName],
    isDirectory: true);

void main() {
  setUpAll(() {
    final mockBoxService = MockBoxService();
    GetIt.I.registerSingleton<BoxService>(mockBoxService);
    when(() => mockBoxService.getAllMangas())
        .thenAnswer((_) => Future.value([mockManga]));
    GetIt.I.registerSingleton<ChapterRepository>(ChapterRepository());
  });

  test('It should create backup dir', () async {
    final backupService =
        BackupService(Directory(cacheDirPath), fileSystem: MemoryFileSystem());
    final _backupDir = await backupService.createBackupDir();

    expect(_backupDir.path, backupDirPath);
    expect(_backupDir.existsSync(), true);
  });
}
