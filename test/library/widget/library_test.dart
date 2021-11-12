import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/library.dart';
import 'package:cross_reader/library/widget/library_list.dart';
import 'package:cross_reader/library/widget/library_list_empty.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import '../../utils/mock_data.dart';
import '../../utils/with_material_app.dart';

class MockLibraryBloc extends MockBloc<LibraryEvent, LibraryState>
    implements LibraryBloc {}

class LibraryStateFake extends Fake implements LibraryState {}

class LibraryEventFake extends Fake implements LibraryEvent {}

class MockMangaRepository extends Mock implements MangaRepository {}

final mockMangaRepository = MockMangaRepository();

void main() {
  setUpAll(() {
    registerFallbackValue(LibraryStateFake());
    registerFallbackValue(LibraryEventFake());

    when(() => mockMangaRepository.mangaList).thenReturn([]);
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
  });
  testWidgets('It should render a FAB btn', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialApp(LibraryPage(LibraryBloc())));

    final fabBtnFinder = find.byType(FloatingActionButton);
    expect(fabBtnFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportFailed',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();

    whenListen(
      mockBlock,
      Stream.fromIterable([ImportFailed()]),
      initialState: Default(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportSucceed',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();

    whenListen(
      mockBlock,
      Stream.fromIterable([ImportSucceed()]),
      initialState: Default(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a CircularProgressIndication on ImportStart',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();

    whenListen(
      mockBlock,
      Stream.fromIterable([ImportStarted()]),
      initialState: Default(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(CircularProgressIndicator);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets(
      'It should render the empty library widget when there is no manga',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();

    whenListen(
      mockBlock,
      Stream.fromIterable([Default()]),
      initialState: Default(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final emptyLibraryFinder = find.byType(LibraryListEmpty);
    expect(emptyLibraryFinder, findsOneWidget);
  });

  testWidgets('It should render the libraryList widget when there is manga',
      (WidgetTester tester) async {
    final mockBlock = MockLibraryBloc();
    reset(mockMangaRepository);
    when(() => mockMangaRepository.mangaList).thenReturn([mockManga]);
    whenListen(
      mockBlock,
      Stream.fromIterable([Default()]),
      initialState: Default(),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBlock)));
    await tester.pump(Duration.zero);

    final emptyLibraryFinder = find.byType(LibraryList);
    expect(emptyLibraryFinder, findsOneWidget);
  });
}
