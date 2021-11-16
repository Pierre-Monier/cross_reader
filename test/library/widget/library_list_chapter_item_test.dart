import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list_chapter_item.dart';
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
  testWidgets('It should render the number of the chapter',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestor(LibraryListChapterItem(mockManga, 0)));

    final titleFinder = find.text(mockManga.chapters[0].name);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('It should render an image', (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestor(LibraryListChapterItem(mockManga, 0)));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets('It should send a ListImages event on tap',
      (WidgetTester tester) async {
    final bloc = LibraryBloc();

    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            LibraryListChapterItem(mockManga, 0), bloc));

    final chapterItemFinder = find.byType(LibraryListChapterItem);
    await tester.tap(chapterItemFinder);
    await tester.pumpAndSettle();

    expect(bloc.state, equals(ShowImages(mockManga, 0)));
  });
}
