import "dart:io";

import "package:cross_reader/repository/chapter_repository.dart";
import "package:cross_reader/service/backup_service.dart";
import "package:cross_reader/service/box_service.dart";
import "package:cross_reader/service/file_helper.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";
import "package:test/test.dart";

import "../utils/mock_class.dart";
import "../utils/mock_data.dart";

final cacheDirPath = Directory.current.path;
final backupDirPath = FileHelper.createPath(
  [cacheDirPath, BackupService.backupDirName],
  isDirectory: true,
);

void main() {
  setUpAll(() {
    final mockBoxService = MockBoxService();
    GetIt.I.registerSingleton<BoxService>(mockBoxService);
    when(mockBoxService.getLocalMangas)
        .thenAnswer((_) => Future.value([mockManga]));
    GetIt.I.registerSingleton<ChapterRepository>(ChapterRepository());
  });
}
