import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/importer/bloc/importer_bloc.dart';
import 'package:cross_reader/importer/importer.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'importer_bloc_test.mocks.dart';
import '../../utils/mock_file_system_entity.dart';

@GenerateMocks([Directory])
void main() {
  blocTest<ImporterBloc, ImporterState>(
      'It emits no state when nothing is called, default state is {"isImporting": false, "importSuccess": null}',
      build: () => ImporterBloc(),
      expect: () => [],
      verify: (bloc) => expect(bloc.state, ImporterDefault()));

  blocTest<ImporterBloc, ImporterState>(
    'It emits a ImporterStarted state when LaunchImport event is trigger',
    build: () => ImporterBloc(),
    act: (bloc) => bloc.add(LaunchImport()),
    expect: () => [ImporterStarted()],
  );

  blocTest<ImporterBloc, ImporterState>(
    'It emits a ImporterFailed state when the imported directory doesn\'t exist',
    build: () => ImporterBloc(),
    act: (bloc) => bloc.add(Import(Directory('fake'))),
    expect: () => [ImporterFailed()],
  );

  blocTest<ImporterBloc, ImporterState>(
    'It emits a ImporterFailed state when the imported directory doesn\'t contains images',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImporterFailed()],
  );

  blocTest<ImporterBloc, ImporterState>(
    'It emits a ImporterSucceed state when the imported directory contains images',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImporterSucceed()],
  );

  blocTest<ImporterBloc, ImporterState>(
    'It handle recursivity, should emit a ImporterSucceed state if files are valid',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(subDirectory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImporterSucceed()],
  );

  blocTest<ImporterBloc, ImporterState>(
    'It handle recursivity, should emit a ImporterFailed state if a file in a subdirectory isn\'t an image',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      final subDirectory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => subDirectory).asStream());
      when(subDirectory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [ImporterFailed()],
  );
}
