import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/reader/reader.dart';
import '../../utils/mock_data.dart';
import '../../utils/with_material_app.dart';

void main() {
  testWidgets('It display the firt image on init', (WidgetTester tester) async {
    final cubit = ReaderCubit(mockImagesPath);
    await tester.pumpWidget(withMaterialApp(ReaderPage(cubit)));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  // Swip left
  // Can't emulate a swipe properly so skipping for now
  testWidgets('It display the next ressource on left swip',
      (WidgetTester tester) async {
    final cubit = ReaderCubit(mockImagesPath);

    await tester.pumpWidget(withMaterialApp(ReaderPage(cubit)));
    final firstImageFinder = find.byType(Image);

    await tester.fling(
        firstImageFinder,
        new Offset(tester.getCenter(firstImageFinder).dx + 100,
            tester.getCenter(firstImageFinder).dy),
        0.5,
        warnIfMissed: true);
    await tester.pumpAndSettle(Duration(seconds: 1));

    final secondImageFinder = find.byType(Image);

    // finders should be different, because the image must have changed
    expect(firstImageFinder.toString() != secondImageFinder.toString(), true);
  }, skip: true);
}
