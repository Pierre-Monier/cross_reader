import 'package:cross_reader/model/chapter.dart';
import 'package:test/test.dart';
import '../utils/mock_data.dart';

void main() {
  test('We can create chapter', () {
    final name = "01";
    final chapter = Chapter(name, mockImagesPath);

    expect(chapter.name, name);
    expect(chapter.imagesPath, mockImagesPath);
  });
}
