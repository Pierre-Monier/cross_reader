import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:get_it/get_it.dart';

class MangaRepository {
  List<Manga> _mangaList = [];
  static final MangaRepository _mangaRepository = MangaRepository._internal();

  factory MangaRepository() {
    return _mangaRepository;
  }

  MangaRepository._internal();

  /// this should only be called by the library bloc
  Future<void> updateMangaList(Directory directory) async {
    Manga manga = await _createManga(directory);
    _mangaRepository._mangaList.add(manga);
  }

  Future<Manga> _createManga(Directory directory) async {
    final name = directory.path.split(Platform.pathSeparator).last;

    List<Directory> subDirectories = await directory.list().toList().then(
        (fileSystemEntityList) =>
            fileSystemEntityList.whereType<Directory>().toList());

    // if their is no subdirectory, we create chapter with the current directory
    // because we are sure that there is images file inside it (test by the library_bloc)
    final futureChapters =
        subDirectories.isEmpty ? [directory] : subDirectories;

    final List<Chapter> chapters = await Future.wait(futureChapters.map(
        (subDirectory) async => await GetIt.I
            .get<ChapterRepository>()
            .createChapter(subDirectory)));

    return Manga(name, chapters);
  }

  List<Manga> get mangaList => _mangaRepository._mangaList;
}
