import 'dart:io';

import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_data.dart';

class MockDirectory extends Mock implements Directory {}

class FakeDirectory extends Fake implements Directory {}

class MockMangaRepository extends Mock implements MangaRepository {}

final mockMangaRepository = MockMangaRepository();

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    registerFallbackValue(FakeDirectory());
    when(() => mockMangaRepository.updateMangaList(any()))
        .thenAnswer((_) => Future(() => null));
  });
  blocTest<LibraryBloc, LibraryState>(
      'It emits no state when nothing is called, ShowMangas state is ShowMangas',
      build: () => LibraryBloc(),
      expect: () => [],
      verify: (bloc) => expect(bloc.state, ShowMangas()));

  blocTest<LibraryBloc, LibraryState>(
    'It emits a ImportStarted state when LaunchImport event is trigger',
    build: () => LibraryBloc(),
    act: (bloc) => bloc.add(LaunchImport()),
    expect: () => [ImportStarted()],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits a ImportFailed state when the imported directory doesn\'t exist',
    build: () => LibraryBloc(),
    act: (bloc) => bloc.add(Import(Directory('fake'))),
    expect: () => [ImportFailed()],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits a ImportFailed state when the imported directory doesn\'t contains images',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImportFailed()],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits a ImportSucceed and ShowMangas state when the imported directory contains images',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());
      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImportSucceed(), ShowMangas()],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit a ImportSucceed state if files are valid',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(() => subDirectory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImportSucceed(), ShowMangas()],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit a ImportFailed state if a file in a subdirectory isn\'t an image',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(() => subDirectory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImportFailed()],
  );

  blocTest<LibraryBloc, LibraryState>(
      'It should emit an ImportFailed state if a directory is valid but empty',
      build: () => LibraryBloc(),
      act: (bloc) {
        final directory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list()).thenAnswer((_) => Stream.empty());

        return bloc.add(Import(directory));
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [ImportFailed()]);
}
