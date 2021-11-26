import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/library.dart';
import 'package:cross_reader/library/widget/library_list_chapter_item.dart';
import 'package:cross_reader/library/widget/library_list_image_item.dart';
import 'package:cross_reader/library/widget/library_list_manga_item.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import '../../utils/mock_data.dart';
import '../../utils/mock_class.dart';
import '../../utils/with_material_app.dart';

final mockMangaRepository = MockMangaRepository();

void main() {
  setUpAll(() {
    registerFallbackValue(LibraryStateFake());
    registerFallbackValue(LibraryEventFake());

    when(() => mockMangaRepository.mangaList).thenReturn([mockManga]);
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
  });

  testWidgets(
      'It should render libraryListMangaItem widget on ShowMangas state',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();
    whenListen(
      mockBloc,
      Stream.fromIterable([
        ShowMangas([mockManga])
      ]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final libraryItemFinder = find.byType(LibraryListMangaItem);
    expect(libraryItemFinder, findsOneWidget);
  });

  testWidgets(
      'It should render libraryListChapterItem widget on ShowChapter state',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();
    whenListen(
      mockBloc,
      Stream.fromIterable([ShowChapters(mockManga.chapters, mockManga)]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final libraryItemFinder = find.byType(LibraryListChapterItem);
    expect(libraryItemFinder, findsWidgets);
  });

  testWidgets(
      'It should render libraryListImageItem widget on ShowImages state',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();
    whenListen(
      mockBloc,
      Stream.fromIterable(
          [ShowImages(mockManga.chapters[0].imagesPath, mockManga, 0)]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final libraryItemFinder = find.byType(LibraryListImageItem);
    expect(libraryItemFinder, findsWidgets);
  });
}
