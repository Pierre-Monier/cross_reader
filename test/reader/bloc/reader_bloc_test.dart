import "package:bloc_test/bloc_test.dart";
import "package:cross_reader/reader/bloc/reader_bloc.dart";
import "package:flutter_test/flutter_test.dart";

import "../../utils/mock_data.dart";

final lastChapterIndex = mockManga.chapters.length - 1;
final lastPageOfLastChapterIndex =
    mockManga.chapters[lastChapterIndex].pagesPath.length - 1;

void main() {
  blocTest<ReaderBloc, ReaderState>(
    "It should emit no state on init, the default state is InitialReaderState",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: 0,
    ),
    verify: (bloc) => expect(
      bloc.state,
      InitialReaderState(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[0],
        currentPage: mockManga.chapters[0].pagesPath[0],
      ),
    ),
  );

  // next
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a NextPage state event on NextPage event",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: 0,
    ),
    act: (bloc) => bloc.add(const ReaderNextEvent()),
    expect: () => [
      NextPageState(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[0],
        currentPage: mockManga.chapters[0].pagesPath[1],
        isNextChapter: false,
      )
    ],
  );

  // next chapter
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a NextPage state which is passing to the new chapter",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: mockManga.chapters[0].pagesPath.length - 1,
    ),
    act: (bloc) => bloc.add(const ReaderNextEvent()),
    expect: () => [
      NextPageState(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[1],
        currentPage: mockManga.chapters[1].pagesPath[0],
        isNextChapter: true,
      )
    ],
  );

  // next last page
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a LastPageInManga state triggering NextEvent on last page",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: lastChapterIndex,
      currentPageIndex: lastPageOfLastChapterIndex,
    ),
    act: (bloc) => bloc.add(const ReaderNextEvent()),
    expect: () => [
      LastPageInManga(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[lastChapterIndex],
        currentPage: mockManga
            .chapters[lastChapterIndex].pagesPath[lastPageOfLastChapterIndex],
      )
    ],
  );

  // previous
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a PreviousPage state event on PreviousPage event",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: 1,
    ),
    act: (bloc) => bloc.add(const ReaderPreviousEvent()),
    expect: () => [
      PreviousPageState(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[0],
        currentPage: mockManga.chapters[0].pagesPath[0],
        isPreviousChapter: false,
      )
    ],
  );

  // previous chapter
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a PreviousPage state which is passing to the previous "
    "chapter event on PreviousPage event",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 1,
      currentPageIndex: 0,
    ),
    act: (bloc) => bloc.add(const ReaderPreviousEvent()),
    expect: () => [
      PreviousPageState(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[0],
        currentPage: mockManga
            .chapters[0].pagesPath[mockManga.chapters[0].pagesPath.length - 1],
        isPreviousChapter: true,
      )
    ],
  );

  // previous first page
  blocTest<ReaderBloc, ReaderState>(
    "It should emit a FirstPageInManga state triggering PreviousEvent on first"
    " page",
    build: () => ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: 0,
    ),
    act: (bloc) => bloc.add(const ReaderPreviousEvent()),
    expect: () => [
      FirstPageInManga(
        currentManga: mockManga,
        currentChapter: mockManga.chapters[0],
        currentPage: mockManga.chapters[0].pagesPath[0],
      )
    ],
  );
}
