import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../utils/mock_data.dart';

void main() {
  blocTest<ReaderCubit, File>(
      'It emits no state when nothing is called, default state is the first File of the images array',
      build: () => ReaderCubit(mockImages),
      expect: () => [],
      verify: (cubit) => expect(cubit.state, mockImages[0]));

  blocTest<ReaderCubit, File>(
      'It emits no state when nothing is called, default state is the custom index of the images array if a custom index is set',
      build: () => ReaderCubit(mockImages, index: 2),
      expect: () => [],
      verify: (cubit) => expect(cubit.state, mockImages[2]));

  blocTest<ReaderCubit, File>(
      'It should emits the n+1 image of the images array when calling next',
      build: () => ReaderCubit(mockImages),
      act: (cubit) => cubit.next(),
      expect: () => [mockImages[1]]);

  blocTest<ReaderCubit, File>(
      'It should emits nothing when calling next and the state is the last image element',
      build: () => ReaderCubit(mockImages, index: (mockImages.length - 1)),
      act: (cubit) => cubit.next(),
      expect: () => []);

  blocTest<ReaderCubit, File>(
      'It should emits the n-1 image of the images array when calling previous',
      build: () => ReaderCubit(mockImages, index: 1),
      act: (cubit) => cubit.previous(),
      expect: () => [mockImages[0]]);

  blocTest<ReaderCubit, File>(
      'It should emits nothing when calling previous and the state is the first image element',
      build: () => ReaderCubit(mockImages),
      act: (cubit) => cubit.previous(),
      expect: () => []);
}
