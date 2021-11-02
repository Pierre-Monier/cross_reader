import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import './importer_event.dart';

class ImporterBloc extends Bloc<ImporterEvent, Map<String, bool?>> {
  static const VALID_IMAGES_FILES = ['png', 'pdf', 'jpeg', 'jpg'];
  ImporterBloc() : super({"isImporting": false, "importSuccess": null}) {
    on<LaunchImport>(
        (event, emit) => emit({"isImporting": true, "importSuccess": null}));

    on<Import>((event, emit) async {
      final directory = event.directory;
      final exists = await directory.exists();
      // We don't check if the files are valid if directory doesn't exist
      final hasValidFiles =
          exists ? await _doesDirHasValidFiles(directory) : false;

      if (!exists || !hasValidFiles) {
        emit({"isImporting": false, "importSuccess": false});
      } else {
        emit({"isImporting": false, "importSuccess": true});
      }
    });
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

      return hasValidFiles;
    } catch (e) {
      return false;
    }
  }
}
