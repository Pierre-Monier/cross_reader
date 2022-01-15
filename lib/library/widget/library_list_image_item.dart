import "dart:io";

import "package:cross_reader/model/manga.dart";
import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:cross_reader/reader/reader.dart";
import "package:flutter/material.dart";

/// A page representation, displayed in page list
class LibraryListPageItem extends StatelessWidget {
  /// A page representation, displayed in page list
  const LibraryListPageItem({
    required this.manga,
    required this.chapterIndex,
    required this.pageIndex,
    Key? key,
  }) : super(key: key);

  /// manga of the page
  final Manga manga;

  /// chapter of the page
  final int chapterIndex;

  /// index of the page
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ReaderPage.routeName,
          arguments: ReaderArguments(
            manga: manga,
            chapterIndex: chapterIndex,
            pageIndex: pageIndex,
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(manga.chapters[chapterIndex].pagesPath[pageIndex]),
                fit: BoxFit.contain,
              ),
            ),
            Text(pageIndex.toString())
          ],
        ),
      ),
    );
  }
}
