import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
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
    );
  }
}
