import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_page.dart';
import 'package:flutter/material.dart';

void main() {
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
