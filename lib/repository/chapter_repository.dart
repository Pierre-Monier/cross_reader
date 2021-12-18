import 'dart:io';

import 'package:cross_reader/model/chapter.dart';

class ChapterRepository {
  Future<Chapter> createChapter(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;
    final imagesPath = await directory.list().map((file) => file.path).toList();

    return Chapter(name, imagesPath);
  }
}
