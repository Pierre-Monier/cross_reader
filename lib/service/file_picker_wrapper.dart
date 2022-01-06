import "dart:io";

import "package:file_picker/file_picker.dart";

/// Service use to pick file entity from device
class FilePickerWrapper {
  /// Service use to pick file entity from device
  FilePickerWrapper(this._filePicker);
  final FilePicker _filePicker;

  /// return the user selected directory or null if the user
  /// cancel the operation
  Future<Directory?> getDirectory() async {
    final selectedDirPath = await _filePicker.getDirectoryPath();
    return (selectedDirPath != null) ? Directory(selectedDirPath) : null;
  }
}
