import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:test/test.dart';

import '../utils/mock_data.dart';

void main() {
  test('We can create manga', () {
    final name = "name";
    final onDevicePath = "/manga/path";
    final chapters = [Chapter("01", mockImagesPath)];
    final manga =
        Manga(name: name, onDevicePath: onDevicePath, chapters: chapters);

    expect(manga.name, name);
    expect(manga.onDevicePath, onDevicePath);
    expect(manga.chapters, chapters);
  });
}
