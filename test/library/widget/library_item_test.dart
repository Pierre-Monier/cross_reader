import "package:cross_reader/library/widget/library_item.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";

import "../../utils/function.dart";
import "../../utils/mock_class.dart";
import "../../utils/mock_data.dart";

const text = "toto";
const imagePath = "/fake";
void main() {
  setUpAll(() {
    final mockMangaRepository = MockMangaRepository();
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
  });
  testWidgets("It should render a text", (WidgetTester tester) async {
    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestor(
        LibraryItem(imagePath: imagePath, text: text, onTap: () {}),
      ),
    );

    final titleFinder = find.text(text);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets("It should render an image", (WidgetTester tester) async {
    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestor(
        LibraryItem(imagePath: imagePath, text: text, onTap: () {}),
      ),
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets("It should call the onTap function onTap",
      (WidgetTester tester) async {
    var toIncrement = 1;

    await tester.pumpWidget(
      withMaterialAppAndWidgetAncestor(
        LibraryItem(
          imagePath: imagePath,
          text: text,
          onTap: () {
            toIncrement += 1;
          },
        ),
      ),
    );

    final chapterItemFinder = find.byType(LibraryItem);
    await tester.tap(chapterItemFinder);
    await tester.pumpAndSettle();

    expect(
      toIncrement,
      2,
    );
  });
}
