import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/library_list_chapter_item.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";

import "../../utils/function.dart";
import "../../utils/mock_class.dart";
import "../../utils/mock_data.dart";

void main() {
  setUpAll(() {
    final mockMangaRepository = MockMangaRepository();
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
  });
  testWidgets("It should render the number of the chapter",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestor(LibraryListChapterItem(mockManga, 0)),
    );

    final titleFinder = find.text(mockManga.chapters[0].name);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets("It should render an image", (WidgetTester tester) async {
    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestor(LibraryListChapterItem(mockManga, 0)),
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets("It should send a ListImages event on tap",
      (WidgetTester tester) async {
    final bloc = LibraryBloc();

    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
        LibraryListChapterItem(mockManga, 0),
        bloc,
      ),
    );

    final chapterItemFinder = find.byType(LibraryListChapterItem);
    await tester.tap(chapterItemFinder);
    await tester.pumpAndSettle();

    expect(
      bloc.state,
      equals(ShowPages(mockManga.chapters[0].pagesPath, mockManga, 0)),
    );
  });
}
