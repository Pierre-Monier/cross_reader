import 'package:bloc_test/bloc_test.dart';
import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list_manga_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_class.dart';
import '../../utils/mock_data.dart';
import '../../utils/with_material_app.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(LibraryStateFake());
    registerFallbackValue(LibraryEventFake());
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
    final mockBloc = MockLibraryBloc();

    whenListen(
      mockBloc,
      Stream.fromIterable([ShowChapters(mockManga)]),
      initialState: ShowMangas(),
    );
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            LibraryListMangaItem(mockManga), mockBloc));

    final mangaItemFinder = find.byType(LibraryListMangaItem);
    await tester.tap(mangaItemFinder);
    await tester.pumpAndSettle();

    expect(mockBloc.state, equals(ShowChapters(mockManga)));
  });
}
