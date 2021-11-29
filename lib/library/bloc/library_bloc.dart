import 'dart:io';

import 'package:cross_reader/model/chapter.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  static const VALID_IMAGES_FILES = ['png', 'pdf', 'jpeg', 'jpg'];

  /// this is use to limit the nested level of import
  ///
  /// ex : Directory -> File : File as a nestedLevel of 1
  ///
  /// ex : Directory -> Directory -> File : File as a nestedLevel of 2
  ///
  /// We don't want a nested level of 3 or more
  static const MAX_IMPORT_NESTED_LEVEL = 2;

  LibraryBloc() : super(Loading()) {
    on<Import>((event, emit) async => await _import(emit));
    on<ListChapters>(
        (event, emit) => emit(ShowChapters(event.chapters, event.manga)));
    on<ListMangas>((event, emit) async => await _listMangas(emit));
    on<ListImages>((event, emit) =>
        emit(ShowImages(event.imagesPath, event.manga, event.chapterIndex)));

    this.add(ListMangas());
  }

  Future<void> _listMangas(Emitter<LibraryState> emit) async {
    final mangaList = await GetIt.I.get<MangaRepository>().mangaList;
    return emit(ShowMangas(mangaList));
  }

  Future<void> _import(Emitter<LibraryState> emit) async {
    emit(Loading());

    final directory = await GetIt.I.get<FilePickerWrapper>().getDirectory();

    if (directory == null) {
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
      return;
    }

    final exists = await directory.exists();
    // We don't check if the files are valid if directory doesn't exist
    final hasValidFiles =
        exists ? await _doesDirHasValidFiles(directory) : false;

    if (!exists || !hasValidFiles) {
      emit(ImportFailed());
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
    } else {
      await GetIt.I<MangaRepository>().addMangaToMangaList(directory);
      emit(ImportSucceed());
      emit(ShowMangas(await GetIt.I.get<MangaRepository>().mangaList));
    }
  }

  Future<bool> _doesDirHasValidFiles(Directory directory,
      {int nestedLevel = 0}) async {
    bool hasValidFiles = true;
    try {
      final List<FileSystemEntity> entities = await directory.list().toList();

      int i = 0;
      while (hasValidFiles &&
          i < entities.length &&
          nestedLevel < MAX_IMPORT_NESTED_LEVEL) {
        FileSystemEntity fileSystemEntity = entities[i];

        if (fileSystemEntity is File) {
          final fileName = fileSystemEntity.path.split('/').last;
          final extension = fileName.split('.').last;
          hasValidFiles = VALID_IMAGES_FILES.contains(extension);
        } else if (fileSystemEntity is Directory) {
          hasValidFiles = await _doesDirHasValidFiles(fileSystemEntity,
              nestedLevel: nestedLevel + 1);
        }

        i++;
      }
      return hasValidFiles &&
          entities.length > 0 &&
          nestedLevel < MAX_IMPORT_NESTED_LEVEL;
    } catch (e) {
      return false;
    }
  }
}
