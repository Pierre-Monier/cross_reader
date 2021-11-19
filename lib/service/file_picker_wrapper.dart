import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerWrapper {
  final FilePicker _filePicker;
  FilePickerWrapper(this._filePicker);

  /// return the user selected directory or null if the user cancel the operation
  Future<Directory?> getDirectory() async {
    final selectedDirPath = await _filePicker.getDirectoryPath();
    return (selectedDirPath != null) ? Directory(selectedDirPath) : null;
  }
}
