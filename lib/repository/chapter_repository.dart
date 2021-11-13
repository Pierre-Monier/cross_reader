import 'dart:io';

import 'package:cross_reader/model/chapter.dart';

class ChapterRepository {
  Future<Chapter> createChapter(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;
    final images =
        await directory.list().map((file) => File(file.path)).toList();

    return Chapter(name, images);
  }
}
