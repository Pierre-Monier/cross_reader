part of "backup_bloc.dart";

/// `BackupBloc` event
abstract class BackupEvent {}

/// `BackupLibrary` trigger the backup of the library
class BackupLibrary extends BackupEvent {
  /// `BackupLibrary` trigger the backup of the library
  BackupLibrary();
}
