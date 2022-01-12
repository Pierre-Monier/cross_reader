part of "library_bloc.dart";

/// States of the `LibraryBloc`
abstract class LibraryState extends Equatable {
  /// States of the `LibraryBloc`
  const LibraryState();

  @override
  List<Object> get props => [];
}

/// The `LibraryBloc` is fetching all `Manga` from the library
class Loading extends LibraryState {
  /// The `LibraryBloc` is fetching all `Manga` from the library
  const Loading() : super();

  @override
  List<Object> get props => [];
}

/// The `LibraryBloc` has fetched all `Manga` from the library
class ImportSucceed extends LibraryState {
  /// The `LibraryBloc` has fetched all `Manga` from the library
  const ImportSucceed() : super();

  @override
  List<Object> get props => [];
}

/// The `LibraryBloc` has failed to fetch all `Manga` from the library
class ImportFailed extends LibraryState {
  /// The `LibraryBloc` has failed to fetch all `Manga` from the library
  const ImportFailed() : super();

  @override
  List<Object> get props => [];
}

/// This state show that I should refactor the import code into another bloc
abstract class LibraryShowState extends LibraryState {
  /// This state show that I should refactor the import code into another bloc
  const LibraryShowState({required this.isEmpty});

  /// Is the library empty
  final bool isEmpty;

  @override
  List<Object> get props => [isEmpty];
}

/// List all `Manga` from the library
class ShowMangas extends LibraryShowState {
  /// List all `Manga` from the library
  ShowMangas(this.mangas) : super(isEmpty: mangas.isEmpty);

  /// all `Manga`
  final List<Manga> mangas;

  @override
  List<Object> get props => [mangas, isEmpty];
}

/// List all chapters of a `Manga`
class ShowChapters extends LibraryShowState {
  /// List all chapters of a `Manga`
  ShowChapters(this.chapters, this.manga) : super(isEmpty: chapters.isEmpty);

  /// all `Chapter`
  final List<Chapter> chapters;

  /// the `Manga` from which we list chapters
  final Manga manga;

  @override
  List<Object> get props => [chapters, manga, isEmpty];
}

/// List all pages of a `Chapter`
class ShowPages extends LibraryShowState {
  /// List all pages of a `Chapter`
  ShowPages(this.imagesPath, this.manga, this.chapterIndex)
      : super(isEmpty: imagesPath.isEmpty);

  /// All pages of a `Chapter`
  final List<String> imagesPath;

  /// The `Manga` from which we list chapters from which we list pages
  final Manga manga;

  /// The index of the current `Chapter` in the `Manga` chapter's list
  final int chapterIndex;

  @override
  List<Object> get props => [imagesPath, manga, chapterIndex, isEmpty];
}
