import "package:cross_reader/model/chapter.dart";
import "package:cross_reader/model/manga.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

part "reader_event.dart";
part "reader_state.dart";

/// Cubit that controls the current page to display
class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  /// Cubit that controls the current page to display
  ReaderBloc({
    required Manga manga,
    required int currentChapterIndex,
    required int currentPageIndex,
  })  : _manga = manga,
        _currentChapterIndex = currentChapterIndex,
        _currentPageIndex = currentPageIndex,
        super(
          InitialReaderState(
            currentManga: manga,
            currentChapter: manga.chapters[currentChapterIndex],
            currentPage:
                manga.chapters[currentChapterIndex].pagesPath[currentPageIndex],
          ),
        ) {
    on<ReaderNextEvent>((_, emit) => _onReaderNextEvent(emit));
    on<ReaderPreviousEvent>((_, emit) => _onReaderPreviousEvent(emit));
  }

  /// The manga to read
  final Manga _manga;
  int _currentChapterIndex;
  int _currentPageIndex;

  /// get the current `Chapter`
  Chapter get currentChapter => _manga.chapters[_currentChapterIndex];

  /// get the current `Page`
  String get currentPage => currentChapter.pagesPath[_currentPageIndex];

  void _onReaderNextEvent(Emitter emit) {
    final isNextChapter =
        _currentPageIndex + 1 > currentChapter.pagesPath.length;
    final isLastChapter = _currentChapterIndex + 1 > _manga.chapters.length;

    if (isNextChapter && isLastChapter) {
      // it's the last page of the last chapter
      // TODO(pierre): create an state for this case
      return;
    } else if (isNextChapter && !isLastChapter) {
      // it's the last page of the current chapter
      _currentPageIndex = 0;
      _currentChapterIndex++;
    } else {
      _currentPageIndex++;
    }

    emit(
      NextPageState(
        currentManga: _manga,
        currentChapter: currentChapter,
        currentPage: currentPage,
        isNextChapter: isNextChapter,
      ),
    );
  }

  void _onReaderPreviousEvent(Emitter emit) {
    final isPreviousChapter = _currentPageIndex == 0;
    final isFirstChapter = _currentChapterIndex == 0;

    if (isPreviousChapter && isFirstChapter) {
      // it's the first page of the first chapter
      // TODO(pierre): create an state for this case
      return;
    } else if (isPreviousChapter && !isFirstChapter) {
      // it's the first page of the current chapter
      _currentChapterIndex--;
      _currentPageIndex = currentChapter.pagesPath.length - 1;
    } else {
      _currentPageIndex--;
    }

    emit(
      PreviousPageState(
        currentManga: _manga,
        currentChapter: currentChapter,
        currentPage: currentPage,
        isPreviousChapter: isPreviousChapter,
      ),
    );
  }
}
