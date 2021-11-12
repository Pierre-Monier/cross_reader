import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:test/test.dart';
import '../utils/mock_images.dart';

void main() {
  test('We can create chapter', () {
    final name = "01";
    final images = mockImages.map((imagePath) => File(imagePath)).toList();
    final chapter = Chapter(name, images);

    expect(chapter.name, name);
    expect(chapter.images, images);
  });
}
