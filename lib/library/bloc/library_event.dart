part of 'library_bloc.dart';

abstract class LibraryEvent {}

class LaunchImport extends LibraryEvent {}

class Import extends LibraryEvent {
  final Directory directory;
  Import(this.directory);
}

class ListChapters extends LibraryEvent {
  final Manga manga;
  ListChapters(this.manga);
}

class ListMangas extends LibraryEvent {
  ListMangas();
}

class ListImages extends LibraryEvent {
  final Manga manga;
  final int chapterIndex;
  ListImages(this.manga, this.chapterIndex);
}
