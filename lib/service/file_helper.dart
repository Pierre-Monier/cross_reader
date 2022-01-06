import "dart:io";

/// Simple service use to create file path
abstract class FileHelper {
  /// create a file path
  static String createPath(
    List<String> parts, {
    bool isDirectory = false,
    bool isArchive = false,
  }) {
    final path = parts.join(Platform.pathSeparator);
    final finalPath = isDirectory
        ? path + Platform.pathSeparator
        : isArchive
            ? "$path.zip"
            : path;
    return finalPath;
  }
}
