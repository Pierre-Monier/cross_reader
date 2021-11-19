import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import 'package:cross_reader/reader/model/reader_arguments.dart';
import 'package:cross_reader/reader/widget/reader_page.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void registerServices() {
  GetIt.instance.registerSingleton<MangaRepository>(MangaRepository());
  GetIt.instance.registerSingleton<ChapterRepository>(ChapterRepository());
  GetIt.instance.registerSingleton<FilePickerWrapper>(
      FilePickerWrapper(FilePicker.platform));
}

void main() {
  registerServices();
  runApp(CrossReaderApp());
}

class CrossReaderApp extends StatelessWidget {
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
