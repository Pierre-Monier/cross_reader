import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void registerSingletons() {
  GetIt.instance.registerSingleton<MangaRepository>(MangaRepository());
}

void main() {
  registerSingletons();
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
