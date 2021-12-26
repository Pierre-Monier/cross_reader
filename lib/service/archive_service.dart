import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_archive/flutter_archive.dart';

class ArchiveService {
  /// compress the [directory] to the [archiveFile] destination
  Future<void> compressDirToArchive(
      {required Directory directory, required File archiveFile}) {
    try {
      return ZipFile.createFromDirectory(
          sourceDir: directory, zipFile: archiveFile, recurseSubDirs: true);
    } catch (e) {
      debugPrint("compressDirToArchive error! $e");
      rethrow;
    }
  }
}
