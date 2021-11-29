import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:test/test.dart';

import '../utils/mock_data.dart';

void main() {
  test('We can create manga', () {
    final name = "name";
    final chapters = [Chapter("01", mockImagesPath)];
    final manga = Manga(name, chapters);

    expect(manga.name, name);
    expect(manga.chapters, chapters);
  });
}
