import "package:cross_reader/model/manga.dart";
import "package:cross_reader/util/app_style.dart";
import "package:flutter/material.dart";

/// The children for a displayed `Manga`
class LibraryItemChapterChild extends StatelessWidget {
  /// The children for a displayed `Manga`

  const LibraryItemChapterChild({
    required this.manga,
    required this.chapterIndex,
    Key? key,
  }) : super(key: key);

  /// The `Manga` of the `Chapter`
  final Manga manga;

  /// The index of the `Chapter` in the chapters array
  final int chapterIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            manga.chapters[chapterIndex].name,
            style: AppStyle.libraryItemTitle,
          ),
        ),
        Expanded(
          child: Text(
            manga.getChapterReadPercentage(chapterIndex),
            style: AppStyle.librayItemPercentage,
          ),
        ),
      ],
    );
  }
}
