import 'dart:io';

abstract class ImporterEvent {}

class LaunchImport extends ImporterEvent {}

class Import extends ImporterEvent {
  final Directory directory;
  Import(this.directory);
}
