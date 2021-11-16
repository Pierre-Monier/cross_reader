import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';

final notAnImageFile = File('notanimage.exe');
final realImageFile = File('image.png');

final mockImages = [
  File("Page01.png"),
  File("Page02.png"),
  File("Page03.png"),
  File("Page04.png"),
  File("Page05.png")
];

final mockChapter1 = Chapter("01", [File("01.jpg")]);
final mockChapter2 = Chapter("02", [File("02.jpg")]);
final mockManga = Manga("mock", [mockChapter1, mockChapter2]);
