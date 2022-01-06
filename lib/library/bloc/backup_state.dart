part of "backup_bloc.dart";

/// `BackupBloc` state
abstract class BackupState extends Equatable {
  /// `BackupBloc` state
  const BackupState();
}

/// `BackupBloc` initial state, nothing is done when this event is trigger
class BackupInit extends BackupState {
  /// `BackupBloc` initial state, nothing is done when this event is trigger
  const BackupInit() : super();

  @override
  List<Object?> get props => [];
}

/// Backup operation was successful
class BackupSuccess extends BackupState {
  /// must provid a list of `Manga` for which the operation failed
  /// and the archive backup file
  const BackupSuccess({required this.fails, required this.archiveBackup})
      : super();

  /// all `Manga` that the operation failed for
  final List<Manga> fails;

  /// the archive backup file
  final File archiveBackup;

  @override
  List<Object?> get props => [fails, archiveBackup];
}

/// Backup operation failed
class BackupFailed extends BackupState {
  /// Backup operation failed
  const BackupFailed() : super();

  @override
  List<Object?> get props => [];
}

/// Backup operation is in progress
class BackupLoading extends BackupState {
  /// Backup operation is in progress
  const BackupLoading() : super();

  @override
  List<Object?> get props => [];
}
