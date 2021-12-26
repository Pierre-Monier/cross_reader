import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import 'package:cross_reader/reader/model/reader_arguments.dart';
import 'package:cross_reader/reader/widget/reader_page.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/archive_service.dart';
import 'package:cross_reader/service/backup_service.dart';
import 'package:cross_reader/service/box_service.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

Future<void> registerServices() async {
  final _cacheDirectory = await getTemporaryDirectory();
  GetIt.I.registerSingleton<BoxService>(BoxService());
  GetIt.I.registerSingleton<MangaRepository>(MangaRepository());
  GetIt.I.registerSingleton<ChapterRepository>(ChapterRepository());
  GetIt.I.registerSingleton<ArchiveService>(ArchiveService());
  GetIt.I.registerSingleton<BackupService>(BackupService(_cacheDirectory));
  GetIt.I.registerSingleton<FilePickerWrapper>(
      FilePickerWrapper(FilePicker.platform));
}

handleErrors() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    } else {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text(
            details.exceptionAsString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  };
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServices();
  handleErrors();
  runApp(const CrossReaderApp());
}

class CrossReaderApp extends StatelessWidget {
  const CrossReaderApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossReader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibraryPage(LibraryBloc()),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/library':
            return MaterialPageRoute(
              builder: (context) => LibraryPage(LibraryBloc()),
            );
          case '/reader':
            final args = settings.arguments as ReaderArguments;
            return MaterialPageRoute(
              builder: (context) =>
                  ReaderPage(ReaderCubit(args.images, index: args.index)),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => LibraryPage(LibraryBloc()),
            );
        }
      },
    );
  }
}
