import 'package:cross_reader/library/bloc/backup_bloc.dart';
import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/library.dart';
import 'package:cross_reader/library/widget/library_list.dart';
import 'package:cross_reader/library/widget/library_list_empty.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import '../../utils/mock_data.dart';
import '../../utils/function.dart';
import '../../utils/mock_class.dart';

final mockMangaRepository = MockMangaRepository();
final mockBackupService = MockBackupService();

// TODO test backup feature when it's done
void main() {
  setUpAll(() {
    registerFallbackValue(LibraryStateFake());
    registerFallbackValue(LibraryEventFake());

    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    GetIt.I.registerSingleton<BackupService>(mockBackupService);
  });
  testWidgets('It should render a FAB btn', (WidgetTester tester) async {
    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: LibraryBloc(),
      backupBloc: BackupBloc(),
    )));

    final fabBtnFinder = find.byType(FloatingActionButton);
    expect(fabBtnFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportFailed',
      (WidgetTester tester) async {
    final mockLibraryBloc = MockLibraryBloc();

    whenListen(
      mockLibraryBloc,
      Stream.fromIterable([ImportFailed()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: mockLibraryBloc,
      backupBloc: BackupBloc(),
    )));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a snackBar on ImportSucceed',
      (WidgetTester tester) async {
    final mockLibraryBloc = MockLibraryBloc();

    whenListen(
      mockLibraryBloc,
      Stream.fromIterable([ImportSucceed()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: mockLibraryBloc,
      backupBloc: BackupBloc(),
    )));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(SnackBar);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets('It should display a CircularProgressIndication on ImportStart',
      (WidgetTester tester) async {
    final mockLibraryBloc = MockLibraryBloc();

    whenListen(
      mockLibraryBloc,
      Stream.fromIterable([Loading()]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: mockLibraryBloc,
      backupBloc: BackupBloc(),
    )));
    await tester.pump(Duration.zero);

    final snackBarFinder = find.byType(CircularProgressIndicator);
    expect(snackBarFinder, findsOneWidget);
  });

  testWidgets(
      'It should render the empty library widget when there is no manga',
      (WidgetTester tester) async {
    final mockLibraryBloc = MockLibraryBloc();

    whenListen(
      mockLibraryBloc,
      Stream.fromIterable([ShowMangas([])]),
      initialState: ShowMangas([]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: mockLibraryBloc,
      backupBloc: BackupBloc(),
    )));

    final emptyLibraryFinder = find.byType(LibraryListEmpty);
    expect(emptyLibraryFinder, findsOneWidget);
  });

  testWidgets('It should\'t pop current route on the ShowChapters event',
      (WidgetTester tester) async {
    final libraryBloc = LibraryBloc();
    final globalNavigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(withMaterialAppAndNavigatorKey(
        LibraryPage(
          libraryBloc: libraryBloc,
          backupBloc: BackupBloc(),
        ),
        globalNavigatorKey));

    libraryBloc.add(ListChapters(mockManga.chapters, mockManga));

    // We wait for the bloc to stream the new state
    await tester.pumpAndSettle(Duration(milliseconds: 100));

    if (globalNavigatorKey.currentState != null) {
      await globalNavigatorKey.currentState!.maybePop();
    } else {
      throw Exception("State of the NavigatorKey is null");
    }

    // we wait for the ListManga event to be processed
    await tester.pumpAndSettle(Duration(milliseconds: 100));

    // triggering maybePop change the bloc state
    expect(libraryBloc.state, equals(ShowMangas([mockManga])));
  });

  testWidgets('It should\'t pop current route on the ShowImages event',
      (WidgetTester tester) async {
    final libraryBloc = LibraryBloc();
    final globalNavigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(withMaterialAppAndNavigatorKey(
        LibraryPage(
          libraryBloc: libraryBloc,
          backupBloc: BackupBloc(),
        ),
        globalNavigatorKey));

    libraryBloc.add(ListImages(mockManga.chapters[0].imagesPath, mockManga, 0));
    // We wait for the bloc to stream the new state
    await tester.pumpAndSettle(Duration(seconds: 1));

    if (globalNavigatorKey.currentState != null) {
      await globalNavigatorKey.currentState!.maybePop();
    } else {
      throw Exception("State of the NavigatorKey is null");
    }

    // triggering maybePop change the bloc state
    expect(
        libraryBloc.state, equals(ShowChapters(mockManga.chapters, mockManga)));
  });
  testWidgets('It should render the libraryList widget when there is manga',
      (WidgetTester tester) async {
    final mockLibraryBloc = MockLibraryBloc();
    reset(mockMangaRepository);
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
    whenListen(
      mockLibraryBloc,
      Stream.fromIterable([
        ShowMangas([mockManga])
      ]),
      initialState: ShowMangas([mockManga]),
    );

    await tester.pumpWidget(withMaterialApp(LibraryPage(
      libraryBloc: mockLibraryBloc,
      backupBloc: BackupBloc(),
    )));

    final emptyLibraryFinder = find.byType(LibraryList);
    expect(emptyLibraryFinder, findsOneWidget);
  });
}
