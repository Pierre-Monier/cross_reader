import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  static const VALID_IMAGES_FILES = ['png', 'pdf', 'jpeg', 'jpg'];
  LibraryBloc() : super(Default()) {
    on<LaunchImport>((event, emit) => emit(ImportStarted()));

    on<Import>((event, emit) async {
      final directory = event.directory;
      final exists = await directory.exists();
      // We don't check if the files are valid if directory doesn't exist
      final hasValidFiles =
          exists ? await _doesDirHasValidFiles(directory) : false;

      if (!exists || !hasValidFiles) {
        emit(ImportFailed());
      } else {
        emit(ImportSucceed());
      }
    });
  }

  Future<bool> _doesDirHasValidFiles(Directory directory) async {
    bool hasValidFiles = true;

    try {
      final List<FileSystemEntity> entities =
          await _getFileSystemEntities(directory);
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

  // We use this wrapper method because we need to use listSync in test env (Stream are hard to mock)
  Future<List<FileSystemEntity>> _getFileSystemEntities(
      Directory directory) async {
    final bool _isTestEnv = Platform.environment.containsKey('FLUTTER_TEST');

    if (_isTestEnv) {
      return directory.listSync();
    } else {
      return directory.list().toList();
    }
  }
}
