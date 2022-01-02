import 'dart:io';

import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  BackupBloc() : super(BackupInit()) {
    on<BackupLibrary>((_, emit) async => await _backup(emit));
  }

  _backup(Emitter<BackupState> emit) async {
    emit(BackupLoading());

    try {
      final backupResponse = await GetIt.I.get<BackupService>().backup();

      emit(BackupSuccess(
          fails: backupResponse.fails,
          archiveBackupDir: backupResponse.archiveBackupDir));
    } catch (e) {
      emit(BackupFailed());
    }
  }
}
