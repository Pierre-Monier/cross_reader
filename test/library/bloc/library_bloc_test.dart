import 'dart:io';

import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_data.dart';
import '../../utils/mock_class.dart';

final mockMangaRepository = MockMangaRepository();
final mockFilePickerWrapper = MockFilePickerWrapper();

void resetMockFilePickerWrapper(Directory? directory) {
  reset(mockFilePickerWrapper);

  when(() => mockFilePickerWrapper.getDirectory())
      .thenAnswer((_) => Future.value(directory));
}

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    GetIt.I.registerSingleton<FilePickerWrapper>(mockFilePickerWrapper);
    registerFallbackValue(FakeDirectory());
    when(() => mockMangaRepository.addMangaToMangaList(any()))
        .thenAnswer((_) => Future.value(null));
    when(() => mockMangaRepository.mangaList).thenReturn([mockManga]);
  });
  blocTest<LibraryBloc, LibraryState>(
      'It emits no state when nothing is called, ShowMangas state is ShowMangas',
      build: () => LibraryBloc(),
      expect: () => [],
      verify: (bloc) => expect(bloc.state, ShowMangas([mockManga])));

  blocTest<LibraryBloc, LibraryState>(
    'It emits an ImportStarted/ImportFailed/ShowMangas state when the imported directory doesn\'t exist',
    build: () => LibraryBloc(),
    act: (bloc) {
      resetMockFilePickerWrapper(Directory('fake'));
      return bloc.add(Import());
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      ImportStarted(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits an ImportStarted/ImportFailed/ShowMangas state when the imported directory doesn\'t contains images',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());
      resetMockFilePickerWrapper(directory);

      return bloc.add(Import());
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      ImportStarted(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits an ImportStarted/ImportSucceed/ShowMangas state when the imported directory contains images',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());
      resetMockFilePickerWrapper(directory);

      return bloc.add(Import());
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      ImportStarted(),
      ImportSucceed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit an ImportStarted/ImportSucceed/ShowMangas state if files are valid',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(() => subDirectory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());
      resetMockFilePickerWrapper(directory);

      return bloc.add(Import());
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      ImportStarted(),
      ImportSucceed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit an ImportStarted/ImportFailed/ShowMangas state if a file in a subdirectory isn\'t an image',
    build: () => LibraryBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(() => directory.exists()).thenAnswer((_) async => true);
      when(() => directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(() => subDirectory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());
      resetMockFilePickerWrapper(directory);

      return bloc.add(Import());
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      ImportStarted(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
      'It should emit an ImportStarted/ImportFailed/ShowMangas state if a directory is valid but empty',
      build: () => LibraryBloc(),
      act: (bloc) {
        final directory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list()).thenAnswer((_) => Stream.empty());
        resetMockFilePickerWrapper(directory);

        return bloc.add(Import());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
            ImportStarted(),
            ImportFailed(),
            ShowMangas([mockManga])
          ]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit a ShowChapters state when triggering the ListChapters',
      build: () => LibraryBloc(),
      act: (bloc) {
        return bloc.add(ListChapters(mockManga.chapters, mockManga));
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [ShowChapters(mockManga.chapters, mockManga)]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit a ShowMangas state when triggering the ListMangas',
      build: () => LibraryBloc(),
      act: (bloc) {
        return bloc.add(ListMangas());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
            ShowMangas([mockManga])
          ]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit a ShowImages state when triggering the ListImages',
      build: () => LibraryBloc(),
      act: (bloc) {
        return bloc.add(ListImages(mockImages, mockManga, 0));
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [ShowImages(mockImages, mockManga, 0)]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit an ImportStarted/ImportFailed/ShowMangas when the selected directory is too nested',
      build: () => LibraryBloc(),
      act: (bloc) {
        final directory = MockDirectory();
        final subDirectory = MockDirectory();
        final subSubDirectory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list())
            .thenAnswer((_) => Future.value(subDirectory).asStream());
        when(() => subDirectory.list())
            .thenAnswer((_) => Future.value(subSubDirectory).asStream());
        when(() => subSubDirectory.list())
            .thenAnswer((_) => Stream.fromIterable(mockImages));
        resetMockFilePickerWrapper(directory);
        return bloc.add(Import());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
            ImportStarted(),
            ImportFailed(),
            ShowMangas([mockManga])
          ]);
}
