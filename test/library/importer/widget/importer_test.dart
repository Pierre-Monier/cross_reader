import 'package:cross_reader/library/importer_fab/importer_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../utils/with_material_app.dart';

void main() {
  testWidgets('It display a btn', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialApp(ImporterFab()));
    final btnFinder = find.byType(FloatingActionButton);
    expect(btnFinder, findsOneWidget);
  });

  testWidgets('It display an Icon', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialApp(ImporterFab()));
    final btnFinder = find.byType(Icon);
    expect(btnFinder, findsOneWidget);
  });

// We can't mock FilePicker easily right now, so it's hard to test
  testWidgets('It should call a method to select a directory on host system',
      (WidgetTester tester) async {
    // MockFilePicker = MockFilePicker();
    // await tester.pumpWidget(withMaterialApp(ImporterFab(mock: MockFilePicker)));
    // tester.tap(find.byType(FloatingActionButton));
    // expect(MockFilePicker.called, true);
  }, skip: true);
}
