part of 'library_bloc.dart';

abstract class LibraryEvent {}

class Import extends LibraryEvent {
  Import();
}

class ListMangas extends LibraryEvent {
  ListMangas();
}

class ListChapters extends LibraryEvent {
  final List<Chapter> chapters;
  final Manga manga;
  ListChapters(this.chapters, this.manga);
}

class ListImages extends LibraryEvent {
  final List<String> imagesPath;
  final Manga manga;
  final int chapterIndex;
  ListImages(this.imagesPath, this.manga, this.chapterIndex);
}
