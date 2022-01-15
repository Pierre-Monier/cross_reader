part of "reader_bloc.dart";

/// `ReaderBloc` state
abstract class ReaderState extends Equatable {
  /// `ReaderBloc` state
  const ReaderState({
    required this.currentManga,
    required this.currentChapter,
    required this.currentPage,
  });

  /// Current manga to read
  final Manga currentManga;

  /// Current chapter of the manga to read
  final Chapter currentChapter;

  /// Current page of the chapter of the manga to read
  final String currentPage;

  @override
  List<Object> get props => [currentManga, currentChapter, currentPage];
}

/// `ReaderBloc` initial state
class InitialReaderState extends ReaderState {
  /// `ReaderBloc` initial state
  const InitialReaderState({
    required Manga currentManga,
    required Chapter currentChapter,
    required String currentPage,
  }) : super(
          currentManga: currentManga,
          currentChapter: currentChapter,
          currentPage: currentPage,
        );
}

/// `ReaderBloc` next page state
class NextPageState extends ReaderState {
  /// `ReaderBloc` next page state
  const NextPageState({
    required Manga currentManga,
    required Chapter currentChapter,
    required String currentPage,
    required this.isNextChapter,
  }) : super(
          currentManga: currentManga,
          currentChapter: currentChapter,
          currentPage: currentPage,
        );

  /// Is reader going to the next chapter
  final bool isNextChapter;

  @override
  List<Object> get props =>
      [currentManga, currentChapter, currentPage, isNextChapter];
}

/// `ReaderBloc` state trigger when the user is at the end of a `Manga`
/// and whant to see the next page
class LastPageInManga extends ReaderState {
  /// `ReaderBloc` state trigger when the user is at the end of a `Manga`
  const LastPageInManga({
    required Manga currentManga,
    required Chapter currentChapter,
    required String currentPage,
  }) : super(
          currentManga: currentManga,
          currentChapter: currentChapter,
          currentPage: currentPage,
        );
}

/// `ReaderBloc` next page state
class PreviousPageState extends ReaderState {
  /// `ReaderBloc` Previous page state
  const PreviousPageState({
    required Manga currentManga,
    required Chapter currentChapter,
    required String currentPage,
    required this.isPreviousChapter,
  }) : super(
          currentManga: currentManga,
          currentChapter: currentChapter,
          currentPage: currentPage,
        );

  /// Is reader going to the next chapter
  final bool isPreviousChapter;

  @override
  List<Object> get props =>
      [currentManga, currentChapter, currentPage, isPreviousChapter];
}

/// `ReaderBloc` state trigger when the user is at the beguinning of a `Manga`
/// and whant to see the previous page
class FirstPageInManga extends ReaderState {
  /// `ReaderBloc` state trigger when the user is at the end of a `Manga`
  const FirstPageInManga({
    required Manga currentManga,
    required Chapter currentChapter,
    required String currentPage,
  }) : super(
          currentManga: currentManga,
          currentChapter: currentChapter,
          currentPage: currentPage,
        );
}
