import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import '../../utils/mock_images.dart';

void main() {
  test('It should give the first ressource if no index is given', () {
    final readerCubit = ReaderCubit(mockImages);

    expect(readerCubit.state, mockImages[0]);
  });

  test('It should give the custom ressource if a custom index is given', () {
    final int customIndex = 1;
    final readerCubit = ReaderCubit(mockImages, index: customIndex);

    expect(readerCubit.state, mockImages[customIndex]);
  });

  test('It should increment the ressource when calling next', () {
    final readerCubit = ReaderCubit(mockImages);
    readerCubit.next();
    expect(readerCubit.state, mockImages[1]);
  });

  test('It should\'t increment when the maximum is reached', () {
    final int customIndex = mockImages.length - 1;
    final readerCubit = ReaderCubit(mockImages, index: customIndex);

    readerCubit.next();
    // the state doesn't move because mockImages length = customIndex + 1
    expect(readerCubit.state, mockImages[customIndex]);
  });

  test('It should decrement the ressource when calling previous', () {
    final int customIndex = 1;
    final readerCubit = ReaderCubit(mockImages, index: customIndex);
    readerCubit.previous();
    expect(readerCubit.state, mockImages[customIndex - 1]);
  });

  test('It should\'t decrement when the minimum (0) is reached', () {
    final readerCubit = ReaderCubit(mockImages);

    readerCubit.previous();
    // the state doesn't move because mockImages length = customIndex + 1
    expect(readerCubit.state, mockImages[0]);
  });
}
