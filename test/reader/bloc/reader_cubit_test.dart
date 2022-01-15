import "package:bloc_test/bloc_test.dart";
import 'package:cross_reader/reader/bloc/reader_bloc.dart';
import "package:flutter_test/flutter_test.dart";

import "../../utils/mock_data.dart";

void main() {
  blocTest<ReaderCubit, String>(
    "It emits no state when nothing is called, default state is the first "
    " String of the images array",
    build: () => ReaderCubit(mockImagesPath),
    expect: () => <String>[],
    verify: (cubit) => expect(cubit.state, mockImagesPath[0]),
  );

  blocTest<ReaderCubit, String>(
    "It emits no state when nothing is called, default state is the custom"
    " index of the images array if a custom index is set",
    build: () => ReaderCubit(mockImagesPath, index: 2),
    expect: () => <String>[],
    verify: (cubit) => expect(cubit.state, mockImagesPath[2]),
  );

  blocTest<ReaderCubit, String>(
    "It should emits the n+1 image of the images array when calling next",
    build: () => ReaderCubit(mockImagesPath),
    act: (cubit) => cubit.next(),
    expect: () => [mockImagesPath[1]],
  );

  blocTest<ReaderCubit, String>(
    "It should emits nothing when calling next and the state is the last"
    " image element",
    build: () => ReaderCubit(mockImagesPath, index: mockImagesPath.length - 1),
    act: (cubit) => cubit.next(),
    expect: () => <String>[],
  );

  blocTest<ReaderCubit, String>(
    "It should emits the n-1 image of the images array when calling previous",
    build: () => ReaderCubit(mockImagesPath, index: 1),
    act: (cubit) => cubit.previous(),
    expect: () => [mockImagesPath[0]],
  );

  blocTest<ReaderCubit, String>(
    "It should emits nothing when calling previous and the state is the first"
    " image element",
    build: () => ReaderCubit(mockImagesPath),
    act: (cubit) => cubit.previous(),
    expect: () => <String>[],
  );
}
