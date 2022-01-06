import "package:flutter_bloc/flutter_bloc.dart";

/// Cubit that controls the current page to display
class ReaderCubit extends Cubit<String> {
  /// Cubit that controls the current page to display
  ReaderCubit(List<String> imagesPaths, {int index = 0})
      : super(imagesPaths[index]) {
    _imagesPaths = imagesPaths;
    _currentIndex = index;
  }
  List<String> _imagesPaths = [];
  int _currentIndex = 0;

  /// Go to the next page
  void next() {
    if (_currentIndex + 1 < _imagesPaths.length) {
      _currentIndex++;
      emit(_imagesPaths[_currentIndex]);
    }
  }

  /// Go to the previous page
  void previous() {
    if (_currentIndex > 0) {
      _currentIndex--;
      emit(_imagesPaths[_currentIndex]);
    }
  }
}
