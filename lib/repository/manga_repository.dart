import "dart:io";

import "package:cross_reader/model/manga.dart";
import "package:cross_reader/repository/chapter_repository.dart";
import "package:cross_reader/service/box_service.dart";
import "package:get_it/get_it.dart";

/// Repository in charge of `Manga` object
class MangaRepository {
  /// constuctor get local `Manga` objects
  MangaRepository() {
    _initDone = _init();
  }

  List<Manga> _mangaList = [];
  late Future<void> _initDone;

  Future<void> _init() async {
    _mangaList = await GetIt.I.get<BoxService>().getLocalMangas();
  }

  /// this should only be called by the library bloc
  Future<int> addMangaToMangaList(Directory directory) async {
    final manga = await _createManga(directory);
    _mangaList.add(manga);
    return GetIt.I.get<BoxService>().saveManga(manga);
  }

  Future<Manga> _createManga(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;

    final subDirectories = await directory.list().toList().then(
          (fileSystemEntityList) =>
              fileSystemEntityList.whereType<Directory>().toList(),
        );

    // if their is no subdirectory, we create chapter with the current directory
    // because we are sure that there is images
    // file inside it (test by the library_bloc)
    final futureChapters =
        subDirectories.isEmpty ? [directory] : subDirectories;
    final chapters = await Future.wait(
      futureChapters.map(
        (subDirectory) =>
            GetIt.I.get<ChapterRepository>().createChapter(subDirectory),
      ),
    );

    return Manga(name: name, onDevicePath: directory.path, chapters: chapters);
  }

  /// get all `Manga` from the library
  Future<List<Manga>> get mangaList async {
    await _initDone;
    return _mangaList;
  }
}
