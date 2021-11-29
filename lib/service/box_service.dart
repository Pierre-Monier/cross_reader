import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxService {
  late Box<Manga> _mangaBox;
  late Future _boxCreated;

  static const mangaBoxKey = 'mangaBoxKey';

  BoxService() {
    _boxCreated = _createBox();
  }

  _createBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Manga>(MangaAdapter());
    Hive.registerAdapter<Chapter>(ChapterAdapter());
    _mangaBox = await Hive.openBox<Manga>(mangaBoxKey);
  }

  Future<List<Manga>> getAllMangas() async {
    await _boxCreated;
    return _mangaBox.values.toList();
  }

  Future<int> saveManga(Manga manga) async {
    await _boxCreated;
    return _mangaBox.add(manga);
  }

  Future<int> cleanMangas() async {
    await _boxCreated;
    return _mangaBox.clear();
  }
}
