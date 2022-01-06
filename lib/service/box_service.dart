import "package:cross_reader/model/chapter.dart";
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
    Hive.registerAdapter<Manga>(MangaAdapter());
    // ignore: cascade_invocations
    Hive.registerAdapter<Chapter>(ChapterAdapter());
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
}
