import "dart:io";

import "package:cross_reader/model/manga.dart";
import "package:cross_reader/service/backup_service.dart";
import "package:cross_reader/service/share_service.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

part "backup_event.dart";
part "backup_state.dart";

/// Bloc for handling backup operations.
class BackupBloc extends Bloc<BackupEvent, BackupState> {
  /// Bloc for handling backup operations.
  BackupBloc() : super(const BackupInit()) {
    on<BackupLibrary>((_, emit) async => _backup(emit));
  }

  Future<void> _backup(Emitter<BackupState> emit) async {
    emit(const BackupLoading());

    try {
      final backupResponse = await GetIt.I.get<BackupService>().backup();
      final backupFilePath = backupResponse.archiveBackupDir.path;

      await GetIt.I.get<ShareService>().shareFile(backupFilePath);

      emit(
        BackupSuccess(
          fails: backupResponse.fails,
          archiveBackup: backupResponse.archiveBackupDir,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(const BackupFailed());
    }
  }
}
