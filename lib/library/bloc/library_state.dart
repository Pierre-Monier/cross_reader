part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class Default extends LibraryState {
  Default() : super();

  @override
  List<Object> get props => [];
}

class ImportStarted extends LibraryState {
  ImportStarted() : super();

  @override
  List<Object> get props => [];
}

class ImportSucceed extends LibraryState {
  ImportSucceed() : super();

  @override
  List<Object> get props => [];
}

class ImportFailed extends LibraryState {
  ImportFailed() : super();

  @override
  List<Object> get props => [];
}
