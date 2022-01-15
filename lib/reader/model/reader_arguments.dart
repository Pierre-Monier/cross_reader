import "package:cross_reader/model/manga.dart";

/// The route parameters of the reader screen
class ReaderArguments {
  /// The route parameters of the reader screen
  ReaderArguments({
    required this.manga,
    required this.chapterIndex,
    required this.pageIndex,
  });

  /// `Manga` to read
  final Manga manga;

  /// index of the chapter to read
  final int chapterIndex;

  /// index of the page to read
  final int pageIndex;
}
