import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:cross_reader/library/widget/library_list_image_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/mock_data.dart';
import '../../utils/with_material_app.dart';

const index = 0;

void main() {
  testWidgets('It should render the number of the imgage',
      (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialAppAndWidgetAncestor(
        LibraryListImageItem(mockImagesPath, index)));

    final titleFinder = find.text(index.toString());
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('It should render an image', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialAppAndWidgetAncestor(
        LibraryListImageItem(mockImagesPath, index)));

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
  });

  testWidgets('It should add a new route to the stack on tap',
      (WidgetTester tester) async {
    final navigatorObserver = NavigationHistoryObserver();
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndNavigatorObserverAndRouteGenerator(
            LibraryListImageItem(mockImagesPath, index), navigatorObserver));

    final imageItemFinder = find.byType(LibraryListImageItem);
    await tester.tap(imageItemFinder);
    await tester.pumpAndSettle();

    // tap on imageItemFinder add a new route to the stack
    expect(navigatorObserver.history.length, 2);
  });
}
