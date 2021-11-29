import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/importer_fab/importer_fab.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../../utils/mock_class.dart';
import '../../../utils/mock_data.dart';
import '../../../utils/function.dart';

void main() {
  setUpAll(() {
    final mockMangaRepository = MockMangaRepository();
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
  });
  testWidgets('It display a btn', (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            ImporterFab(), LibraryBloc()));
    final btnFinder = find.byType(FloatingActionButton);
    expect(btnFinder, findsOneWidget);
  });

  testWidgets('It display an Icon', (WidgetTester tester) async {
    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            ImporterFab(), LibraryBloc()));
    final btnFinder = find.byType(Icon);
    expect(btnFinder, findsOneWidget);
  });

// We can't mock FilePicker easily right now, so it's hard to test
  testWidgets('It should call a method to select a directory on host system',
      (WidgetTester tester) async {
    final mockFilePickerWrapper = MockFilePickerWrapper();
    when(() => mockFilePickerWrapper.getDirectory())
        .thenAnswer((_) => Future(() => null));
    GetIt.I.registerSingleton<FilePickerWrapper>(mockFilePickerWrapper);

    await tester.pumpWidget(
        withMaterialAppAndWidgetAncestorAndBlocProvider<LibraryBloc>(
            ImporterFab(), LibraryBloc()));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(Duration.zero);

    verify(() => mockFilePickerWrapper.getDirectory()).called(1);
  });
}
