import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderCubit extends Cubit<String> {
  List<String> _imagesPaths = [];
  int _currentIndex = 0;
  ReaderCubit(List<String> ressources, {int index = 0})
      : super(ressources[index]) {
    _imagesPaths = ressources;
    _currentIndex = index;
  }

  void next() {
    if (_currentIndex + 1 < _imagesPaths.length) {
      _currentIndex++;
      emit(_imagesPaths[_currentIndex]);
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      _currentIndex--;
      emit(_imagesPaths[_currentIndex]);
    }
  }
}