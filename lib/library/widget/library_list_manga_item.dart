import 'dart:io';

import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryListMangaItem extends StatelessWidget {
  final Manga _manga;
  const LibraryListMangaItem(this._manga, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<LibraryBloc>(context)
            .add(ListChapters(_manga.chapters, _manga));
      },
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              File(_manga.chapters[0].imagesPath[0]),
              fit: BoxFit.contain,
            )),
            Text(_manga.name)
          ])),
    );
  }
}
