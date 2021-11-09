part of 'importer_bloc.dart';

abstract class ImporterEvent {}

class LaunchImport extends ImporterEvent {}

class Import extends ImporterEvent {
  final Directory directory;
  Import(this.directory);
}
