import 'dart:io';

import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:get_it/get_it.dart';

class MangaRepository {
  List<Manga> _mangaList = [];
  late Future _initDone;

  MangaRepository() {
    _initDone = _init();
  }

  _init() async {
    _mangaList = await GetIt.I.get<BoxService>().getAllMangas();
  }

  /// this should only be called by the library bloc
  Future<int> addMangaToMangaList(Directory directory) async {
    Manga manga = await _createManga(directory);
    _mangaList.add(manga);
    return GetIt.I.get<BoxService>().saveManga(manga);
  }

  Future<Manga> _createManga(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;

    final subDirectories = await directory.list().toList().then(
        (fileSystemEntityList) =>
            fileSystemEntityList.whereType<Directory>().toList());

    // if their is no subdirectory, we create chapter with the current directory
    // because we are sure that there is images file inside it (test by the library_bloc)
    final futureChapters =
        subDirectories.isEmpty ? [directory] : subDirectories;
    final chapters = await Future.wait(futureChapters.map(
        (subDirectory) async => await GetIt.I
            .get<ChapterRepository>()
            .createChapter(subDirectory)));

    return Manga(name, chapters);
  }

  Future<List<Manga>> get mangaList async {
    await _initDone;
    return _mangaList;
  }
}
