import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/model/manga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryListChapterItem extends StatelessWidget {
  final Manga _manga;
  final int _chapterIndex;
  const LibraryListChapterItem(this._manga, this._chapterIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<LibraryBloc>(context).add(ListImages(
            _manga.chapters[_chapterIndex].images, _manga, _chapterIndex));
      },
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              _manga.chapters[_chapterIndex].images[0],
              fit: BoxFit.contain,
            )),
            Text(_manga.chapters[_chapterIndex].name)
          ])),
    );
  }
}
