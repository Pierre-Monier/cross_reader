import "package:cross_reader/model/chapter.dart";
import "package:cross_reader/model/last_readed.dart";
import "package:cross_reader/model/manga.dart";
import "package:hive_flutter/hive_flutter.dart";

/// Service used to access local storage
class BoxService {
  /// Service used to access local storage
  BoxService() {
    _boxCreated = _createBox();
  }
  late Box<Manga> _mangaBox;
  late Future _boxCreated;

  static const _mangaBoxKey = "mangaBoxKey";

  Future<void> _createBox() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter<Manga>(MangaAdapter())
      ..registerAdapter<Chapter>(ChapterAdapter())
      ..registerAdapter<LastReaded>(LastReadedAdapter());
    _mangaBox = await Hive.openBox<Manga>(_mangaBoxKey);
  }

  /// Get all manga from local data
  Future<List<Manga>> getLocalMangas() async {
    await _boxCreated;
    return _mangaBox.values.toList();
  }

  /// Save a manga to local data
  Future<int> saveManga(Manga manga) async {
    await _boxCreated;
    return _mangaBox.add(manga);
  }

  /// Remove all manga from local data
  Future<int> cleanMangas() async {
    await _boxCreated;
    return _mangaBox.clear();
  }

  /// just testing for now
  Future<void> updateManga(Manga manga) async {
    await _boxCreated;
    return _mangaBox.put(manga.key, manga);
  }
}
