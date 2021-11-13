import 'package:cross_reader/model/manga.dart';
import 'package:flutter/material.dart';

class LibraryListMangaItem extends StatelessWidget {
  final Manga _manga;
  const LibraryListMangaItem(this._manga, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("TAPED"),
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              _manga.chapters[0].images[0],
              fit: BoxFit.contain,
            )),
            Text(_manga.name)
          ])),
    );
  }
}
