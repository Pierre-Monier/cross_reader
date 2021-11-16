import 'dart:io';

import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import 'package:cross_reader/reader/widget/reader_page.dart';
import 'package:cross_reader/repository/chapter_repository.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void registerServices() {
  GetIt.instance.registerSingleton<MangaRepository>(MangaRepository());
  GetIt.instance.registerSingleton<ChapterRepository>(ChapterRepository());
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
            final images = settings.arguments as List<File>;
            return MaterialPageRoute(
              builder: (context) => ReaderPage(ReaderCubit(images)),
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
