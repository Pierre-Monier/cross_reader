import "package:cross_reader/library/library.dart";
import "package:cross_reader/library/widget/importer_fab.dart";
import "package:cross_reader/library/widget/library_list_chapter_item.dart";
import "package:cross_reader/library/widget/library_list_image_item.dart";
import "package:cross_reader/library/widget/library_list_manga_item.dart";
import "package:cross_reader/main.dart";
import "package:cross_reader/reader/widget/reader_page.dart";
import "package:cross_reader/repository/chapter_repository.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:cross_reader/service/box_service.dart";
import "package:cross_reader/service/file_picker_wrapper.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get_it/get_it.dart";
import "package:mocktail/mocktail.dart";

import "../test/utils/mock_class.dart";
import "../test/utils/mock_data.dart";

final FilePickerWrapper mockFilePickerWrapper = MockFilePickerWrapper();

void main() {
  setUpAll(() async {
    GetIt.instance.registerSingleton<BoxService>(BoxService());
    GetIt.instance.registerSingleton<MangaRepository>(MangaRepository());
    GetIt.instance.registerSingleton<ChapterRepository>(ChapterRepository());
    GetIt.I.registerSingleton<FilePickerWrapper>(mockFilePickerWrapper);
    await GetIt.I.get<BoxService>().cleanMangas();
  });
  testWidgets("It should render the library page by default",
      (WidgetTester tester) async {
    await tester.pumpWidget(const CrossReaderApp());

    final libraryPageFinder = find.byType(LibraryPage);

    expect(libraryPageFinder, findsOneWidget);
  });

  testWidgets("It should be able to import manga and read it",
      (WidgetTester tester) async {
    final mockDirectory = MockDirectory();
    final mockSubDirectory = MockDirectory();

    when(mockDirectory.list)
        .thenAnswer((_) => Future.value(mockSubDirectory).asStream());
    when(mockDirectory.existsSync).thenReturn(true);
    when(() => mockDirectory.path).thenReturn("/manga");

    when(mockSubDirectory.list)
        .thenAnswer((_) => Stream.fromIterable(onDevicemockImagesPath));
    when(mockDirectory.existsSync).thenReturn(true);
    when(() => mockSubDirectory.path).thenReturn("/manga/chapter");

    when(mockFilePickerWrapper.getDirectory)
        .thenAnswer((_) => Future.value(mockDirectory));

    await tester.pumpWidget(const CrossReaderApp());

    final importerFabFinder = find.byType(ImporterFab);

    await tester.tap(importerFabFinder);
    await tester.pumpAndSettle();

    final mangaItemFinder = find.byType(LibraryListMangaItem);

    expect(mangaItemFinder, findsOneWidget);

    await tester.tap(mangaItemFinder);
    await tester.pumpAndSettle();

    final chapterItemFinder = find.byType(LibraryListChapterItem);

    expect(chapterItemFinder, findsOneWidget);

    await tester.tap(chapterItemFinder);
    await tester.pumpAndSettle();

    final imageItemFinder = find.byType(LibraryListPageItem);

    expect(imageItemFinder, findsNWidgets(onDevicemockImagesPath.length));

    await tester.tap(imageItemFinder.first);
    await tester.pumpAndSettle();

    final readerPageFinder = find.byType(ReaderPage);

    expect(readerPageFinder, findsOneWidget);
  });
}
