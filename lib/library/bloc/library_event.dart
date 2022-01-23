part of "library_bloc.dart";

/// The Event of the `LibraryBloc`
abstract class LibraryEvent {}

/// `Import` event represents the event of importing content to the library
class Import extends LibraryEvent {
  /// `Import` event represents the event of importing content to the library
  Import();
}

/// `ListMangas` event represents the event of listing mangas in the library
class ListMangas extends LibraryEvent {
  /// `ListMangas` event represents the event of listing mangas in the library
  ListMangas();
}

/// `ListChapters` event represents the event of listing chapters of a `Manga`
class ListChapters extends LibraryEvent {
  /// needs all `Chapter` object of the manga and the `Manga` object
  ListChapters(this.chapters, this.manga);

  /// All `Chapter` objects of the manga
  final List<Chapter> chapters;

  /// The `Manga` object
  final Manga manga;
}

/// `ListPages` event represents the event of listing pages of a `Chapter`
class ListPages extends LibraryEvent {
  /// needs all images path of the chapter and the `Chapter` object
  /// and the `Manga` object
  ListPages(this.imagesPath, this.manga, this.chapterIndex);

  /// All images path of the chapter
  final List<String> imagesPath;

  /// The `Manga` object
  final Manga manga;

  /// The index of the chapter in the `Chapter` list of the manga
  final int chapterIndex;
}
