import 'dart:io';

abstract class FileHelper {
  static String createPath(List<String> parts, {isDirectory = false}) {
    final path = parts.join(Platform.pathSeparator);
    return isDirectory ? '$path${Platform.pathSeparator}' : path;
  }
}
