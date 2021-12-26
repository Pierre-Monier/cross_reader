import 'dart:io';

abstract class FileHelper {
  static String createPath(List<String> parts,
      {isDirectory = false, isArchive = false}) {
    final path = parts.join(Platform.pathSeparator);
    final finalPath = isDirectory
        ? path + Platform.pathSeparator
        : isArchive
            ? path + '.zip'
            : path;
    return finalPath;
  }
}
