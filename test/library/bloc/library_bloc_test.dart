import 'dart:io';

import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import '../../utils/mock_data.dart';
import '../../utils/mock_class.dart';
import '../../utils/function.dart';

final mockMangaRepository = MockMangaRepository();
final mockFilePickerWrapper = MockFilePickerWrapper();
final mockBackupService = MockBackupService();

void resetMockFilePickerWrapper(Directory? directory) {
  reset(mockFilePickerWrapper);

  when(() => mockFilePickerWrapper.getDirectory())
      .thenAnswer((_) => Future.value(directory));
}

void main() {
  setUpAll(() {
    final mockBoxService = MockBoxService();
    GetIt.I.registerSingleton<BoxService>(mockBoxService);
    GetIt.I.registerSingleton<MangaRepository>(mockMangaRepository);
    GetIt.I.registerSingleton<FilePickerWrapper>(mockFilePickerWrapper);
    GetIt.I.registerSingleton<BackupService>(mockBackupService);
    registerFallbackValue(FakeDirectory());
    when(() => mockMangaRepository.addMangaToMangaList(any()))
        .thenAnswer((_) => Future.value(1));
    when(() => mockMangaRepository.mangaList)
        .thenAnswer((_) => Future.value([mockManga]));
    registerFallbackValue(FakeManga());
    when(() => mockBoxService.saveManga(any()))
        .thenAnswer((_) => Future.value(1));
  });

  blocTest<LibraryBloc, LibraryState>(
    'It emits no state when nothing is called, it emit a ShowMangas',
    build: () => LibraryBloc(),
    expect: () => [
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits an Loading/ImportFailed/ShowMangas state when the imported directory doesn\'t exist',
    build: () => LibraryBloc(),
    act: (bloc) async {
      await withDebounce(() {
        resetMockFilePickerWrapper(Directory('fake'));
        return bloc.add(Import());
      });
    },
    wait: const Duration(milliseconds: 300),
    skip: 1,
    expect: () => [
      Loading(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits an Loading/ImportFailed/ShowMangas state when the imported directory doesn\'t contains images',
    build: () => LibraryBloc(),
    act: (bloc) async {
      await withDebounce(() {
        final directory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list())
            .thenAnswer((_) => Future(() => notAnImageFile).asStream());
        resetMockFilePickerWrapper(directory);

        return bloc.add(Import());
      });
    },
    wait: const Duration(milliseconds: 300),
    skip: 1,
    expect: () => [
      Loading(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It emits an Loading/ImportSucceed/ShowMangas state when the imported directory contains images',
    build: () => LibraryBloc(),
    act: (bloc) async {
      await withDebounce(() {
        final directory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list())
            .thenAnswer((_) => Future(() => realImageFile).asStream());
        resetMockFilePickerWrapper(directory);

        return bloc.add(Import());
      });
    },
    wait: const Duration(milliseconds: 1000),
    skip: 1,
    expect: () => [
      Loading(),
      ImportSucceed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit an Loading/ImportSucceed/ShowMangas state if files are valid',
    build: () => LibraryBloc(),
    act: (bloc) async {
      await withDebounce(() {
        final directory = MockDirectory();
        final subDirectory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list())
            .thenAnswer((_) => Future(() => subDirectory).asStream());
        when(() => subDirectory.list())
            .thenAnswer((_) => Future(() => realImageFile).asStream());
        resetMockFilePickerWrapper(directory);

        return bloc.add(Import());
      });
    },
    wait: const Duration(milliseconds: 300),
    skip: 1,
    expect: () => [
      Loading(),
      ImportSucceed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
    'It handle recursivity, should emit an Loading/ImportFailed/ShowMangas state if a file in a subdirectory isn\'t an image',
    build: () => LibraryBloc(),
    act: (bloc) async {
      await withDebounce(() {
        final directory = MockDirectory();
        final subDirectory = MockDirectory();
        when(() => directory.exists()).thenAnswer((_) async => true);
        when(() => directory.list())
            .thenAnswer((_) => Future(() => subDirectory).asStream());
        when(() => subDirectory.list())
            .thenAnswer((_) => Future(() => notAnImageFile).asStream());
        resetMockFilePickerWrapper(directory);

        return bloc.add(Import());
      });
    },
    wait: const Duration(milliseconds: 300),
    skip: 1,
    expect: () => [
      Loading(),
      ImportFailed(),
      ShowMangas([mockManga])
    ],
  );

  blocTest<LibraryBloc, LibraryState>(
      'It should emit an Loading/ImportFailed/ShowMangas state if a directory is valid but empty',
      build: () => LibraryBloc(),
      act: (bloc) async {
        await withDebounce(() {
          final directory = MockDirectory();
          when(() => directory.exists()).thenAnswer((_) async => true);
          when(() => directory.list()).thenAnswer((_) => Stream.empty());
          resetMockFilePickerWrapper(directory);

          return bloc.add(Import());
        });
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
      expect: () => [
            Loading(),
            ImportFailed(),
            ShowMangas([mockManga])
          ]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit a ShowChapters state when triggering the ListChapters',
      build: () => LibraryBloc(),
      act: (bloc) async {
        await withDebounce(() {
          return bloc.add(ListChapters(mockManga.chapters, mockManga));
        });
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
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
        return bloc.add(ListImages(mockImagesPath, mockManga, 0));
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
      expect: () => [ShowImages(mockImagesPath, mockManga, 0)]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit an Loading/ImportFailed/ShowMangas when the selected directory is too nested',
      build: () => LibraryBloc(),
      act: (bloc) async {
        await withDebounce(() {
          final directory = MockDirectory();
          final subDirectory = MockDirectory();
          final subSubDirectory = MockDirectory();
          when(() => directory.exists()).thenAnswer((_) async => true);
          when(() => directory.list())
              .thenAnswer((_) => Future.value(subDirectory).asStream());
          when(() => subDirectory.list())
              .thenAnswer((_) => Future.value(subSubDirectory).asStream());
          when(() => subSubDirectory.list())
              .thenAnswer((_) => Stream.fromIterable(mockImagesFile));
          resetMockFilePickerWrapper(directory);
          return bloc.add(Import());
        });
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
      expect: () => [
            Loading(),
            ImportFailed(),
            ShowMangas([mockManga])
          ]);

  blocTest<LibraryBloc, LibraryState>(
      'It should emit a BackupSuccess state if backup is successful',
      build: () => LibraryBloc(),
      act: (bloc) {
        when(() => mockBackupService.backup())
            .thenAnswer((_) => Future.value(successBackupResponse));
        return bloc.add(BackupLibrary());
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
      expect: () => [
            BackupLoading(),
            BackupSuccess(
                fails: [mockManga], archiveBackupDir: mockArchiveBackupDir)
          ]);

  blocTest<LibraryBloc, LibraryState>(
      "It should emit a BackupFailed state if backup isn't successful",
      build: () => LibraryBloc(),
      act: (bloc) {
        when(() => mockBackupService.backup())
            .thenAnswer((_) => throw Exception());
        return bloc.add(BackupLibrary());
      },
      wait: const Duration(milliseconds: 300),
      skip: 1,
      expect: () => [BackupLoading(), BackupFailed()]);
}
