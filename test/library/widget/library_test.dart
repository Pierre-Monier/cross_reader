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
import '../../utils/mock_class.dart';

final mockMangaRepository = MockMangaRepository();

void main() {
  setUpAll(() {
    registerFallbackValue(LibraryStateFake());
    registerFallbackValue(LibraryEventFake());

    when(() => mockMangaRepository.mangaList).thenReturn([mockManga]);
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
  });
  testWidgets('It should render a FAB btn', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialApp(LibraryPage(LibraryBloc())));

    final fabBtnFinder = find.byType(FloatingActionButton);
    expect(fabBtnFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportFailed',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();

    whenListen(
      mockBloc,
      Stream.fromIterable([ImportFailed()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportSucceed',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();

    whenListen(
      mockBloc,
      Stream.fromIterable([ImportSucceed()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a CircularProgressIndication on ImportStart',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();

    whenListen(
      mockBloc,
      Stream.fromIterable([ImportStarted()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(CircularProgressIndicator);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets(
      'It should render the empty library widget when there is no manga',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();

    whenListen(
      mockBloc,
      Stream.fromIterable([ShowMangas([])]),
      initialState: ShowMangas([]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));

    final emptyLibraryFinder = find.byType(LibraryListEmpty);
    expect(emptyLibraryFinder, findsOneWidget);
  });

  testWidgets('It should\'t pop current route on the ShowChapters event',
      (WidgetTester tester) async {
    final bloc = LibraryBloc();
    final globalNavigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
        withMaterialAppAndNavigatorKey(LibraryPage(bloc), globalNavigatorKey));

    bloc.add(ListChapters(mockManga.chapters, mockManga));
    // We wait for the bloc to stream the new state
    await tester.pumpAndSettle(Duration(seconds: 1));

    if (globalNavigatorKey.currentState != null) {
      await globalNavigatorKey.currentState!.maybePop();
    } else {
      throw Exception("State of the NavigatorKey is null");
    }

    // triggering maybePop change the bloc state
    expect(bloc.state, equals(ShowMangas([mockManga])));
  });

  testWidgets('It should\'t pop current route on the ShowImages event',
      (WidgetTester tester) async {
    final bloc = LibraryBloc();
    final globalNavigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
        withMaterialAppAndNavigatorKey(LibraryPage(bloc), globalNavigatorKey));

    bloc.add(ListImages(mockManga.chapters[0].imagesPath, mockManga, 0));
    // We wait for the bloc to stream the new state
    await tester.pumpAndSettle(Duration(seconds: 1));

    if (globalNavigatorKey.currentState != null) {
      await globalNavigatorKey.currentState!.maybePop();
    } else {
      throw Exception("State of the NavigatorKey is null");
    }

    // triggering maybePop change the bloc state
    expect(bloc.state, equals(ShowChapters(mockManga.chapters, mockManga)));
  });
  testWidgets('It should render the libraryList widget when there is manga',
      (WidgetTester tester) async {
    final mockBloc = MockLibraryBloc();
    reset(mockMangaRepository);
    when(() => mockMangaRepository.mangaList).thenReturn([mockManga]);
    whenListen(
      mockBloc,
      Stream.fromIterable([
        ShowMangas([mockManga])
      ]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(mockBloc)));

    final emptyLibraryFinder = find.byType(LibraryList);
    expect(emptyLibraryFinder, findsOneWidget);
  });
}
