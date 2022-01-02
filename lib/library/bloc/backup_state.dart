part of 'backup_bloc.dart';

abstract class BackupState extends Equatable {
  const BackupState();
}

class BackupInit extends BackupState {
  const BackupInit() : super();

  @override
  List<Object?> get props => [];
}

class BackupSuccess extends BackupState {
  final List<Manga> fails;
  final File archiveBackupDir;

  const BackupSuccess({required this.fails, required this.archiveBackupDir})
      : super();

  @override
  List<Object?> get props => [fails, archiveBackupDir];
}

class BackupFailed extends BackupState {
  const BackupFailed() : super();

  @override
  List<Object?> get props => [];
}

class BackupLoading extends BackupState {
  const BackupLoading() : super();

  @override
  List<Object?> get props => [];
}
