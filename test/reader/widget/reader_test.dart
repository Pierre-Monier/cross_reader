import "package:cross_reader/reader/reader.dart";
import "package:flutter/widgets.dart";
import "package:flutter_test/flutter_test.dart";

import "../../utils/function.dart";
import "../../utils/mock_data.dart";

void main() {
  testWidgets("It display the firt image on init", (WidgetTester tester) async {
    final bloc = ReaderBloc(
      manga: mockManga,
      currentChapterIndex: 0,
      currentPageIndex: 0,
    );
    await tester.pumpWidget(
      withMaterialApp(
        ReaderPage(
          readerBloc: bloc,
        ),
      ),
    );

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  // Swip left
  // Can"t emulate a swipe properly so skipping for now
  testWidgets(
    "It display the next ressource on left swip",
    (WidgetTester tester) async {
      final bloc = ReaderBloc(
        manga: mockManga,
        currentChapterIndex: 0,
        currentPageIndex: 0,
      );

      await tester.pumpWidget(
        withMaterialApp(
          ReaderPage(
            readerBloc: bloc,
          ),
        ),
      );
      final firstImageFinder = find.byType(Image);

      await tester.fling(
        firstImageFinder,
        Offset(
          tester.getCenter(firstImageFinder).dx + 100,
          tester.getCenter(firstImageFinder).dy,
        ),
        0.5,
      );
      await tester.pumpAndSettle();

      final secondImageFinder = find.byType(Image);

      // finders should be different, because the image must have changed
      expect(firstImageFinder.toString() != secondImageFinder.toString(), true);
    },
    skip: true,
  );
}
