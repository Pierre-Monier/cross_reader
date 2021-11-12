import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';

final notAnImageFile = File('notanimage.exe');
final realImageFile = File('image.png');

const mockImages = [
  'assets/dev/Page01.png',
  'assets/dev/Page02.png',
  'assets/dev/Page03.png',
  'assets/dev/Page04.png',
  'assets/dev/Page05.png'
];

final mockChapter1 = Chapter("01", [File("01.jpg")]);
final mockChapter2 = Chapter("02", [File("02.jpg")]);
final mockManga = Manga("mock", [mockChapter1, mockChapter2]);
