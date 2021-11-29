import 'dart:io';

import 'package:cross_reader/model/chapter.dart';

class ChapterRepository {
  Future<Chapter> createChapter(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;
    final imagesPath = await directory.list().map((file) => file.path).toList();

    return Chapter(name, imagesPath);
  }

  List<Chapter> transformImagesPath(String newDirPath, List<Chapter> chapters) {
    return chapters.map((chapter) {
      final List<String> images = chapter.imagesPath.map((imagePath) {
        return '$newDirPath/${chapter.name}/$imagePath';
      }).toList();
      return Chapter(chapter.name, images);
    }).toList();
  }
}
