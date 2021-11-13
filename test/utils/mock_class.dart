import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';


class MockLibraryBloc extends MockBloc<LibraryEvent, LibraryState>
    implements LibraryBloc {}

class LibraryStateFake extends Fake implements LibraryState {}

class LibraryEventFake extends Fake implements LibraryEvent {}

class MockMangaRepository extends Mock implements MangaRepository {}
