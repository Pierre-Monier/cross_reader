import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import '../utils/mock_class.dart';

void main() {
  test('It should return null when the user doesn\'t select a dir', () async {
    final mockFilePicker = MockFilePicker();
    when(() => mockFilePicker.getDirectoryPath())
        .thenAnswer((_) => Future.value(null));
    final filePickerWrapper = FilePickerWrapper(mockFilePicker);

    final directory = await filePickerWrapper.getDirectory();

    expect(directory, null);
  });

  test('It should return a Directory when the user select a dir', () async {
    const directoryPath = '/path/to/dir';
    final mockFilePicker = MockFilePicker();
    when(() => mockFilePicker.getDirectoryPath())
        .thenAnswer((_) => Future.value(directoryPath));
    final filePickerWrapper = FilePickerWrapper(mockFilePicker);

    final directory = await filePickerWrapper.getDirectory();

    expect(directory != null, true);
    expect(directory!.path, directoryPath);
  });
}
