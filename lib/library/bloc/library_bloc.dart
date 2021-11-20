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
  LibraryBloc() : super(ShowMangas(GetIt.I.get<MangaRepository>().mangaList)) {
    on<Import>((event, emit) async => await _import(emit));
    on<ListChapters>(
        (event, emit) => emit(ShowChapters(event.chapters, event.manga)));
    on<ListMangas>((event, emit) =>
        emit(ShowMangas(GetIt.I.get<MangaRepository>().mangaList)));
    on<ListImages>((event, emit) =>
        emit(ShowImages(event.images, event.manga, event.chapterIndex)));
  }

  Future<void> _import(Emitter<LibraryState> emit) async {
    emit(ImportStarted());

    final directory = await GetIt.I.get<FilePickerWrapper>().getDirectory();

    if (directory == null) {
      return;
    }

    final exists = await directory.exists();
    // We don't check if the files are valid if directory doesn't exist
    final hasValidFiles =
        exists ? await _doesDirHasValidFiles(directory) : false;

    if (!exists || !hasValidFiles) {
      emit(ImportFailed());
    } else {
      await GetIt.I<MangaRepository>().updateMangaList(directory);
      emit(ImportSucceed());
      // we don't want the lasted state to be ImportSucceed
      // because if the user do two imports, the view won't rereder (because it's the same state)
      // we can't relly on buildWhen function because it isn't trigger
      // so we emit the ShowMangas state to avoid this behavior
      emit(ShowMangas(GetIt.I.get<MangaRepository>().mangaList));
    }
  }

  Future<bool> _doesDirHasValidFiles(Directory directory) async {
    bool hasValidFiles = true;

    try {
      final List<FileSystemEntity> entities = await directory.list().toList();

      int i = 0;
      while (hasValidFiles && i < entities.length) {
        FileSystemEntity fileSystemEntity = entities[i];

        if (fileSystemEntity is File) {
          final fileName = fileSystemEntity.path.split('/').last;
          final extension = fileName.split('.').last;
          hasValidFiles = VALID_IMAGES_FILES.contains(extension);
        } else if (fileSystemEntity is Directory) {
          hasValidFiles = await _doesDirHasValidFiles(fileSystemEntity);
        }

        i++;
      }

      return hasValidFiles && entities.length > 0;
    } catch (e) {
      return false;
    }
  }
}
