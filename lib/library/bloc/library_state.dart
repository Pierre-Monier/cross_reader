part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  final Map<String, bool?> value;

  const LibraryState(this.value);

  @override
  List<Object> get props => [value];
}

class Default extends LibraryState {
  Default() : super({"isImporting": false, "importSuccess": null});

  @override
  List<Object> get props => [value];
}

class ImportStarted extends LibraryState {
  ImportStarted() : super({"isImporting": true, "importSuccess": null});

  @override
  List<Object> get props => [value];
}

class ImportSucceed extends LibraryState {
  ImportSucceed() : super({"isImporting": false, "importSuccess": true});

  @override
  List<Object> get props => [value];
}

class ImportFailed extends LibraryState {
  ImportFailed() : super({"isImporting": false, "importSuccess": false});

  @override
  List<Object> get props => [value];
}
