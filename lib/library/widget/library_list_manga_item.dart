import "dart:io";

import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/model/manga.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// A `Manga` representation, displayed in manga list
class LibraryListMangaItem extends StatelessWidget {
  /// A `Manga` representation, displayed in manga list
  const LibraryListMangaItem(this._manga, {Key? key}) : super(key: key);
  final Manga _manga;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<LibraryBloc>(context)
            .add(ListChapters(_manga.chapters, _manga));
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(_manga.chapters[0].pagesPath[0]),
                fit: BoxFit.contain,
              ),
            ),
            Text(_manga.name)
          ],
        ),
      ),
    );
  }
}
