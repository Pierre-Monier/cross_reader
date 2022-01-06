import "dart:io";

import "package:cross_reader/model/manga.dart";
import "package:cross_reader/service/backup_service.dart";
import "package:equatable/equatable.dart";
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

      emit(
        BackupSuccess(
          fails: backupResponse.fails,
          archiveBackup: backupResponse.archiveBackupDir,
        ),
      );
    } catch (e) {
      emit(const BackupFailed());
    }
  }
}
