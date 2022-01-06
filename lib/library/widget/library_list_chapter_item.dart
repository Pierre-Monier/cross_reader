import "dart:io";

import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/model/manga.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// A `Chapter` representation, displayed in the list of chapters.
class LibraryListChapterItem extends StatelessWidget {
  /// A `Chapter` representation, displayed in the list of chapters.
  const LibraryListChapterItem(this._manga, this._chapterIndex, {Key? key})
      : super(key: key);
  final Manga _manga;
  final int _chapterIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<LibraryBloc>(context).add(
          ListImages(
            _manga.chapters[_chapterIndex].pagesPath,
            _manga,
            _chapterIndex,
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(_manga.chapters[_chapterIndex].pagesPath[0]),
                fit: BoxFit.contain,
              ),
            ),
            Text(_manga.chapters[_chapterIndex].name)
          ],
        ),
      ),
    );
  }
}
