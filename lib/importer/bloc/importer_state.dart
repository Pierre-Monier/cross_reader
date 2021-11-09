part of 'importer_bloc.dart';

abstract class ImporterState extends Equatable {
  final Map<String, bool?> value;

  const ImporterState(this.value);

  @override
  List<Object> get props => [value];
}

class ImporterDefault extends ImporterState {
  ImporterDefault() : super({"isImporting": false, "importSuccess": null});

  @override
  List<Object> get props => [value];
}

class ImporterStarted extends ImporterState {
  ImporterStarted() : super({"isImporting": true, "importSuccess": null});

  @override
  List<Object> get props => [value];
}

class ImporterSucceed extends ImporterState {
  ImporterSucceed() : super({"isImporting": false, "importSuccess": true});

  @override
  List<Object> get props => [value];
}

class ImporterFailed extends ImporterState {
  ImporterFailed() : super({"isImporting": false, "importSuccess": false});

  @override
  List<Object> get props => [value];
}
