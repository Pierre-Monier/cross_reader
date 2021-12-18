import 'dart:io';

class ProcessService {
  const ProcessService();

  /// copy directory using system shell
  ///
  /// will throw an error if the exit code is not 0
  Future<void> copyDirectory(
      {required Directory destination, required Directory source}) async {
    final result =
        await Process.run("cp", ["-r", source.path, destination.path]);
    if (result.exitCode != 0) {
      throw Exception("Failed to copy directory: ${result.stderr}");
    }
  }
}
