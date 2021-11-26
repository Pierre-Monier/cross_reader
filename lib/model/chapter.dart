import 'dart:io';

import 'package:cross_reader/model/manga.dart';

class Chapter {
  final String name;
  final List<String> imagesPath;
  late Manga manga;

  Chapter(this.name, this.imagesPath);
}
