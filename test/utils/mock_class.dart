import "dart:io";

import "package:bloc_test/bloc_test.dart";
import "package:cross_reader/library/bloc/backup_bloc.dart";
import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/model/manga.dart";
import "package:cross_reader/repository/chapter_repository.dart";
import "package:cross_reader/repository/manga_repository.dart";
import "package:cross_reader/service/backup_service.dart";
import "package:cross_reader/service/box_service.dart";
import "package:cross_reader/service/file_picker_wrapper.dart";
import "package:file_picker/file_picker.dart";
import "package:mocktail/mocktail.dart";

class MockLibraryBloc extends MockBloc<LibraryEvent, LibraryState>
    implements LibraryBloc {}

class LibraryStateFake extends Fake implements LibraryState {}

class LibraryEventFake extends Fake implements LibraryEvent {}

class MockMangaRepository extends Mock implements MangaRepository {}

class MockFilePickerWrapper extends Mock implements FilePickerWrapper {}

class MockDirectory extends Mock implements Directory {}

class MockBoxService extends Mock implements BoxService {}

class FakeDirectory extends Fake implements Directory {}

class FakeManga extends Fake implements Manga {}

class MockFilePicker extends Mock implements FilePicker {}

class MockChapterRepository extends Mock implements ChapterRepository {}

class MockBackupService extends Mock implements BackupService {}

class MockBackupBloc extends MockBloc<BackupEvent, BackupState>
    implements BackupBloc {}
