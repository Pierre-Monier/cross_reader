import "dart:io";

import "package:cross_reader/service/file_helper.dart";
import "package:test/test.dart";

void main() {
  test("It should return a string separate by path separaor", () async {
    const strings = ["a", "b", "c"];
    final path = FileHelper.createPath(strings);

    expect(path, "a${Platform.pathSeparator}b${Platform.pathSeparator}c");
  });

  test("It should add a path separaor at the end of directory path", () async {
    const strings = ["a", "b", "c"];
    final path = FileHelper.createPath(strings, isDirectory: true);

    expect(path,
        "a${Platform.pathSeparator}b${Platform.pathSeparator}c${Platform.pathSeparator}");
  });
}
