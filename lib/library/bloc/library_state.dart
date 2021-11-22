part of 'library_bloc.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object> get props => [];
}

class ImportStarted extends LibraryState {
  const ImportStarted() : super();

  @override
  List<Object> get props => [];
}

class ImportSucceed extends LibraryState {
  const ImportSucceed() : super();

  @override
  List<Object> get props => [];
}

class ImportFailed extends LibraryState {
  const ImportFailed() : super();

  @override
  List<Object> get props => [];
}

abstract class LibraryShowState extends LibraryState {
  final bool isEmpty;
  LibraryShowState(this.isEmpty);

  @override
  List<Object> get props => [isEmpty];
}

class ShowMangas extends LibraryShowState {
  final List<Manga> mangas;
  ShowMangas(this.mangas) : super(mangas.isEmpty);

  @override
  List<Object> get props => [mangas, isEmpty];
}

class ShowChapters extends LibraryShowState {
  final List<Chapter> chapters;
  final Manga manga;
  ShowChapters(this.chapters, this.manga) : super(chapters.isEmpty);

  @override
  List<Object> get props => [chapters, manga, isEmpty];
}

class ShowImages extends LibraryShowState {
  final List<File> images;
  final Manga manga;
  final int chapterIndex;
  ShowImages(this.images, this.manga, this.chapterIndex)
      : super(images.isEmpty);

  @override
  List<Object> get props => [images, manga, chapterIndex, isEmpty];
}
