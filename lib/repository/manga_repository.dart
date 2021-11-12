// a singleton repository class for manga model
import 'package:cross_reader/model/manga.dart';

class MangaRepository {
  List<Manga> _mangaList = [];
  static final MangaRepository _mangaRepository = MangaRepository._internal();

  factory MangaRepository() {
    return _mangaRepository;
  }

  MangaRepository._internal() {
    _loadMangaList();
  }

  _loadMangaList() {
    _mangaRepository._mangaList = [];
  }

  // updateMangaList() {
  //   _mangaRepository._tmp = "titi";
  // }

  List<Manga> get mangaList => _mangaList;
}
