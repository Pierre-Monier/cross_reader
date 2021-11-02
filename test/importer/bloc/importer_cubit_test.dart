import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:cross_reader/importer/bloc/importer_bloc.dart';
import 'package:cross_reader/importer/bloc/importer_event.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'importer_cubit_test.mocks.dart';
import '../../utils/mock_file_system_entity.dart';

@GenerateMocks([Directory])
void main() {
  blocTest<ImporterBloc, Map<String, bool?>>(
      'It emits no state when nothing is called, default state is {"isImporting": false, "importSuccess": null}',
      build: () => ImporterBloc(),
      expect: () => [],
      verify: (bloc) =>
          expect(bloc.state, {"isImporting": false, "importSuccess": null}));

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It emits a sate with isImporting: true when LaunchImport event is trigger',
    build: () => ImporterBloc(),
    act: (bloc) => bloc.add(LaunchImport()),
    expect: () => [
      {"isImporting": true, "importSuccess": null}
    ],
  );

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It emits a sate with isImporting: false and importSuccess false when the imported directory doesn\'t exist',
    build: () => ImporterBloc(),
    act: (bloc) => bloc.add(Import(Directory('fake'))),
    expect: () => [
      {"isImporting": false, "importSuccess": false}
    ],
  );

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It emits a sate with isImporting: false and importSuccess false when the imported directory doesn\'t contains images',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => notAnImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      {"isImporting": false, "importSuccess": false}
    ],
  );

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It emits a sate with isImporting: false and importSuccess: true when the imported directory contains images',
    build: () => ImporterBloc(),
    act: (bloc) {
      final directory = MockDirectory();
      when(directory.exists()).thenAnswer((_) async => true);
      when(directory.list())
          .thenAnswer((_) => Future(() => realImageFile).asStream());

      return bloc.add(Import(directory));
    },
    wait: const Duration(milliseconds: 300),
    expect: () => [
      {"isImporting": false, "importSuccess": true}
    ],
  );

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It handle recursivity, should emit a state with importSuccess: true if files are valid',
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
    expect: () => [
      {"isImporting": false, "importSuccess": true}
    ],
  );

  blocTest<ImporterBloc, Map<String, bool?>>(
    'It handle recursivity, should emit a state with importSuccess: false if a file in a subdirectory isn\'t an image',
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
    expect: () => [
      {"isImporting": false, "importSuccess": false}
    ],
  );
}
