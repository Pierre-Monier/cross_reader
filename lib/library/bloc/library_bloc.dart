import "dart:io";

import "package:cross_reader/model/chapter.dart";
import "package:cross_reader/model/manga.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:cross_reader/service/file_picker_wrapper.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

part "library_event.dart";
part "library_state.dart";

/// Bloc that is responsible for the library
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  /// The `LibraryBloc` is init whith the `Loading` state and it add
  /// the `ListMangas` event at the end of the init
  LibraryBloc() : super(const Loading()) {
    on<Import>((event, emit) => _import(emit));
    on<ListChapters>(
      (event, emit) => emit(ShowChapters(event.chapters, event.manga)),
    );
    on<ListMangas>((event, emit) => _listMangas(emit));
    on<ListImages>(
      (event, emit) =>
          emit(ShowPages(event.imagesPath, event.manga, event.chapterIndex)),
    );
    add(ListMangas());
  }

  /// list of type file that the library can handle
  static const validImagesFiles = ["png", "jpeg", "jpg"];

  /// this is use to limit the nested level of import
  ///
  /// ex : Directory -> File : File as a nestedLevel of 1
  ///
  /// ex : Directory -> Directory -> File : File as a nestedLevel of 2
  ///
  /// We don"t want a nested level of 3 or more
  static const maxImportNestedLevel = 2;

  Future<void> _listMangas(Emitter<LibraryState> emit) async {
    final mangaList = await GetIt.I.get<MangaRepository>().mangaList;
    return emit(ShowMangas(mangaList));
  }

  Future<void> _import(Emitter<LibraryState> emit) async {
    emit(const Loading());

    final directory = await GetIt.I.get<FilePickerWrapper>().getDirectory();

    if (directory == null) {
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
      return;
    }

    final exists = directory.existsSync();
    // We don"t check if the files are valid if directory doesn"t exist
    final hasValidFiles = exists && await _doesDirHasValidFiles(directory);

    if (!exists || !hasValidFiles) {
      emit(const ImportFailed());
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
    } else {
      await GetIt.I<MangaRepository>().addMangaToMangaList(directory);
      emit(const ImportSucceed());
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
    }

    emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
  }

  Future<bool> _doesDirHasValidFiles(
    Directory directory, {
    int nestedLevel = 0,
  }) async {
    var hasValidFiles = true;
    try {
      final entities = await directory.list().toList();

      var i = 0;
      while (hasValidFiles &&
          i < entities.length &&
          nestedLevel < maxImportNestedLevel) {
        final fileSystemEntity = entities[i];

        if (fileSystemEntity is File) {
          final fileName = fileSystemEntity.path.split("/").last;
          final extension = fileName.split(".").last;
          hasValidFiles = validImagesFiles.contains(extension);
        } else if (fileSystemEntity is Directory) {
          hasValidFiles = await _doesDirHasValidFiles(
            fileSystemEntity,
            nestedLevel: nestedLevel + 1,
          );
        }

        i++;
      }
      return hasValidFiles &&
          entities.isNotEmpty &&
          nestedLevel < maxImportNestedLevel;
    } catch (e) {
      return false;
    }
  }
}
