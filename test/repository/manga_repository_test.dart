import 'dart:io';

import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/mock_data.dart';

class MockDirectory extends Mock implements Directory {}

class MockChapterRepository extends Mock implements ChapterRepository {}

void main() {
  test('We can access mangaList', () {
    final mangaRepository = MangaRepository();

    expect(mangaRepository.mangaList, []);
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

    await mangaRepository.updateMangaList(mockDirectory);
    expect(mangaRepository.mangaList.length, 1);
    expect(mangaRepository.mangaList[0].name,
        mockDirectoryPath.split(Platform.pathSeparator).last);
    expect(mangaRepository.mangaList[0].chapters, [mockChapter1]);
  });
}
