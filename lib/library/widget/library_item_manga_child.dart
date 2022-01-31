import "package:cross_reader/model/manga.dart";
import "package:cross_reader/util/app_spacing.dart";
import "package:cross_reader/util/app_style.dart";
import "package:flutter/material.dart";

/// The child for a displayed `Manga`
class LibraryItemMangaChild extends StatelessWidget {
  /// The child for a displayed `Manga`
  const LibraryItemMangaChild({required this.manga, Key? key})
      : super(key: key);

  /// The `Manga` to display
  final Manga manga;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                manga.name,
                maxLines: 2,
                style: AppStyle.libraryItemTitle,
              ),
            ),
            AppSpacing.smallHorizontalSpace,
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  manga.readPercentage,
                  // textAlign: TextAlign.end,
                  style: AppStyle.librayItemPercentage,
                ),
              ),
            )
          ],
        ),
        AppSpacing.smallVerticalSpace,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${manga.chapters.length} chapters",
            textAlign: TextAlign.start,
            style: AppStyle.libraryItemSubData,
          ),
        ),
      ],
    );
  }
}
