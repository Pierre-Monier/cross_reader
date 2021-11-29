import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list_manga_item.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_class.dart';
import '../../utils/mock_data.dart';
import '../../utils/function.dart';

void main() {
  setUpAll(() {
    final mockMangaRepository = MockMangaRepository();
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
  });
  testWidgets('It should render the title of the manga',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestor(LibraryListMangaItem(mockManga)));

    final titleFinder = find.text(mockManga.name);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('It should render an image', (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestor(LibraryListMangaItem(mockManga)));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets('It should send a ListChapters event on tap',
      (WidgetTester tester) async {
    final bloc = LibraryBloc();

    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            LibraryListMangaItem(mockManga), bloc));

    final mangaItemFinder = find.byType(LibraryListMangaItem);
    await tester.tap(mangaItemFinder);
    await tester.pumpAndSettle();

    expect(bloc.state, equals(ShowChapters(mockManga.chapters, mockManga)));
  });
}
