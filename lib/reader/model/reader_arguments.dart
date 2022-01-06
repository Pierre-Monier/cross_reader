/// The route parameters of the reader screen
class ReaderArguments {
  /// The route parameters of the reader screen
  ReaderArguments(this.pages, this.index);

  /// list of pages to read
  final List<String> pages;

  /// current page index
  final int index;
}
