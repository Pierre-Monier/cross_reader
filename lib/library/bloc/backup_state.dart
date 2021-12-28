part of 'backup_bloc.dart';

abstract class BackupState {
  const BackupState();
}

class BackupInit extends BackupState {
  const BackupInit() : super();
}

class BackupSuccess extends BackupState {
  final List<Manga> fails;
  final File archiveBackupDir;

  const BackupSuccess({required this.fails, required this.archiveBackupDir})
      : super();
}

class BackupFailed extends BackupState {
  const BackupFailed() : super();
}

class BackupLoading extends BackupState {
  const BackupLoading() : super();
}
