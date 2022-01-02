import 'package:cross_reader/library/bloc/backup_bloc.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_data.dart';
import '../../utils/mock_class.dart';

final mockBackupService = MockBackupService();

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<BackupService>(mockBackupService);
  });
  blocTest<BackupBloc, BackupState>(
      'It should emit a BackupSuccess state if backup is successful',
      build: () => BackupBloc(),
      act: (bloc) {
        when(() => mockBackupService.backup())
            .thenAnswer((_) => Future.value(successBackupResponse));
        return bloc.add(BackupLibrary());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
            BackupLoading(),
            BackupSuccess(
                fails: [mockManga], archiveBackupDir: mockArchiveBackupDir)
          ]);

  blocTest<BackupBloc, BackupState>(
      "It should emit a BackupFailed state if backup isn't successful",
      build: () => BackupBloc(),
      act: (bloc) {
        when(() => mockBackupService.backup())
            .thenAnswer((_) => throw Exception());
        return bloc.add(BackupLibrary());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [BackupLoading(), BackupFailed()]);
}
