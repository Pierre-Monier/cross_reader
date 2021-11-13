import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/library.dart';
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
    final mockBlock = MockLibraryBloc();
    whenListen(
      mockBlock,
      Stream.fromIterable([ShowMangas()]),
      initialState: ShowMangas(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final libraryItemFinder = find.byType(LibraryListMangaItem);
    expect(libraryItemFinder, findsOneWidget);
  });

  testWidgets(
      'It should render libraryListChapterItem widget on ShowChapter state',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();
    whenListen(
      mockBlock,
      Stream.fromIterable([ShowMangas()]),
      initialState: ShowMangas(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final libraryItemFinder = find.byType(LibraryListChapterItem);
    expect(libraryItemFinder, findsOneWidget);
  }, skip: true);
}
