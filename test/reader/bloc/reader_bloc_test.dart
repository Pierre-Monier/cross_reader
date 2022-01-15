import "package:bloc_test/bloc_test.dart";
import "package:cross_reader/reader/bloc/reader_bloc.dart";
import "package:flutter_test/flutter_test.dart";

import '../../utils/function.dart';
import "../../utils/mock_data.dart";

void main() {
  // blocTest<ReaderBloc, ReaderState>(
  //   "It should emit no state on init, the default state is InitialReaderState",
  //   build: () => ReaderBloc(
  //     manga: mockManga,
  //     currentChapterIndex: 0,
  //     currentPageIndex: 0,
  //   ),
  //   verify: (bloc) => expect(
  //     bloc.state,
  //     InitialReaderState(
  //       currentManga: mockManga,
  //       currentChapter: mockManga.chapters[0],
  //       currentPage: mockManga.chapters[0].pagesPath[0],
  //     ),
  //   ),
  // );

  // // next
  // blocTest<ReaderBloc, ReaderState>(
  //   "It should emit a NextPage state event on NextPage event",
  //   build: () => ReaderBloc(
  //     manga: mockManga,
  //     currentChapterIndex: 0,
  //     currentPageIndex: 0,
  //   ),
  //   act: (bloc) => const ReaderNextEvent(),
  //   wait: const Duration(milliseconds: 1000),
  //   expect: () => [
  //     NextPageState(
  //       currentManga: mockManga,
  //       currentChapter: mockManga.chapters[0],
  //       currentPage: mockManga.chapters[0].pagesPath[0],
  //       isNextChapter: false,
  //     )
  //   ],
  // );

  // // next chapter
  // blocTest<ReaderBloc, ReaderState>(
  //   "It should emit a NextPage state which is passing to the new chapter",
  //   build: () => ReaderBloc(
  //     manga: mockManga,
  //     currentChapterIndex: 0,
  //     currentPageIndex: mockManga.chapters[0].pagesPath.length - 1,
  //   ),
  //   act: (bloc) => bloc.add(const ReaderNextEvent()),
  //   wait: const Duration(seconds: 2),
  //   expect: () => [
  //     NextPageState(
  //       currentManga: mockManga,
  //       currentChapter: mockManga.chapters[1],
  //       currentPage: mockManga.chapters[1].pagesPath[0],
  //       isNextChapter: true,
  //     )
  //   ],
  // );

  // next last page
  // blocTest<ReaderBloc, ReaderState>(
  //   "It should emit a LastPageInManga state triggering NextEvent on last page",
  //   build: () => ReaderBloc(
  //     manga: mockManga,
  //     currentChapterIndex: mockManga.chapters.length - 1,
  //     currentPageIndex: mockManga.chapters[0].pagesPath.length - 1,
  //   ),
  //   act: (bloc) => bloc.add(const ReaderNextEvent()),
  //   wait: const Duration(seconds: 2),
  //   expect: () => [
  //     LastPageInManga(
  //       currentManga: mockManga,
  //       currentChapter: mockManga.chapters[mockManga.chapters.length - 1],
  //       currentPage: mockManga.chapters[mockManga.chapters.length - 1]
  //           .pagesPath[mockManga.chapters[0].pagesPath.length - 1],
  //     )
  //   ],

  // );
  // previous

  // previous chapter

  // previous first page
}
