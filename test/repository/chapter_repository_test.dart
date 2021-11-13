import 'dart:io';

import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/mock_data.dart';

class MockDirectory extends Mock implements Directory {}

void main() {
  test('We can create chapter based on file', () async {
    final chapterRepository = ChapterRepository();
    final mockDirectory = MockDirectory();
    final mockDirectoryPath = "/manga";

    when(() => mockDirectory.path).thenReturn(mockDirectoryPath);
    when(() => mockDirectory.list())
        .thenAnswer((invocation) => Future.value(realImageFile).asStream());

    final chapter = await chapterRepository.createChapter(mockDirectory);

    expect(chapter.name, mockDirectoryPath.split(Platform.pathSeparator).last);
    expect(chapter.images[0].path, realImageFile.path);
  });
}
