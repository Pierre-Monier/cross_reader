part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  LibraryState();

  @override
  List<Object> get props => [];
}

class ShowMangas extends LibraryState {
  ShowMangas() : super();

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

class ShowChapters extends LibraryState {
  final Manga manga;
  ShowChapters(this.manga) : super();

  @override
  List<Object> get props => [manga];
}

class ShowImages extends LibraryState {
  final Manga manga;
  final int chapterIndex;
  ShowImages(this.manga, this.chapterIndex) : super();

  @override
  List<Object> get props => [manga, chapterIndex];
}
