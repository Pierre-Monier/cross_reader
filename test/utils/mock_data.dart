import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';

final notAnImageFile = File('notanimage.exe');
final realImageFile = File('image.png');

final mockImagesPath = [
  "test_ressources/Page01.png",
  "test_ressources/Page02.png",
  "test_ressources/Page03.png",
  "test_ressources/Page04.png",
  "test_ressources/Page05.png"
];

final mockImagesFile = [
  File("test_ressources/Page01.png"),
  File("test_ressources/Page02.png"),
  File("test_ressources/Page03.png"),
  File("test_ressources/Page04.png"),
  File("test_ressources/Page05.png")
];

final onDevicemockImagesPath = [
  File("/storage/emulated/0/Documents/Page01.png"),
  File("/storage/emulated/0/Documents/Page02.png"),
  File("/storage/emulated/0/Documents/Page03.png"),
  File("/storage/emulated/0/Documents/Page04.png"),
  File("/storage/emulated/0/Documents/Page05.png")
];

final mockManga = Manga("mock", [mockChapter1, mockChapter2]);
final mockChapter1 = Chapter("01", ["test_ressources/Page01.png"]);
final mockChapter2 = Chapter("02", ["test_ressources/Page02.png"]);
