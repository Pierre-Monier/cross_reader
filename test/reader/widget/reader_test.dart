import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/reader/reader.dart';
import '../../utils/mock_images.dart';

void main() {
  testWidgets('It display the firt image on init', (WidgetTester tester) async {
    await tester.pumpWidget(ReaderPage(mockImages));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  // Swip left
  // Can't emulate a swipe properly so skipping for now
  testWidgets('It display the next ressource on left swip',
      (WidgetTester tester) async {
    await tester.pumpWidget(ReaderPage(mockImages));
    final finder = find.text(mockImages[0]);

    await tester.fling(
        finder,
        new Offset(
            tester.getCenter(finder).dx + 100, tester.getCenter(finder).dy),
        0.5,
        warnIfMissed: true);
    await tester.pumpAndSettle();
    final newFinder = find.text(mockImages[1]);
    expect(newFinder, findsOneWidget);
  }, skip: true);
}
