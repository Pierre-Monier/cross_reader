import 'dart:io';

import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/mock_data.dart';
import '../utils/mock_class.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(FakeManga());
    final mockBoxService = MockBoxService();
    when(() => mockBoxService.saveManga(any()))
        .thenAnswer((_) => Future.value(1));
    when(() => mockBoxService.getAllMangas())
        .thenAnswer((_) => Future.value([]));
    GetIt.I.registerSingleton<BoxService>(mockBoxService);
  });
  test('We can access mangaList', () async {
    final mangaRepository = MangaRepository();
    final mangaList = await mangaRepository.mangaList;
    expect(mangaList, []);
  });

  test('We can update mangaList', () async {
    final mockChapterRepository = MockChapterRepository();
    GetIt.I.registerSingleton<ChapterRepository>(mockChapterRepository);

    final mangaRepository = MangaRepository();
    final mockDirectory = MockDirectory();
    final mockDirectoryPath = "/manga";
    final mockSubDirectory = MockDirectory();
    final mockSubDirectoryPath = "/manga/test";

    when(() => mockDirectory.path).thenReturn(mockDirectoryPath);
    when(() => mockDirectory.list())
        .thenAnswer((_) => Future(() => mockSubDirectory).asStream());
    when(() => mockSubDirectory.path).thenReturn(mockSubDirectoryPath);
    when(() => mockSubDirectory.list())
        .thenAnswer((_) => Future(() => realImageFile).asStream());
    when(() => mockChapterRepository.createChapter(mockSubDirectory))
        .thenAnswer((_) => Future.value(mockChapter1));

    await mangaRepository.addMangaToMangaList(mockDirectory);
    final mangaList = await mangaRepository.mangaList;
    expect(mangaList.length, 1);
    expect(mangaList[0].name,
        mockDirectoryPath.split(Platform.pathSeparator).last);
    expect(mangaList[0].chapters, [mockChapter1]);
  });
}
