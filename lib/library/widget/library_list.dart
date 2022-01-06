import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/library_list_chapter_item.dart";
import "package:cross_reader/library/widget/library_list_image_item.dart";
import "package:cross_reader/library/widget/library_list_manga_item.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// Widget that controller which list to render, based on current `LibraryState`
class LibraryList extends StatelessWidget {
  /// Widget that controller which list to render,
  /// based on current `LibraryState`
  const LibraryList({Key? key}) : super(key: key);

  int _getItemCount(LibraryState state) {
    if (state is ShowMangas) {
      return state.mangas.length;
    } else if (state is ShowChapters) {
      return state.manga.chapters.length;
    } else if (state is ShowPages) {
      return state.manga.chapters[state.chapterIndex].pagesPath.length;
    } else {
      return 0;
    }
  }

  Widget _getItem(LibraryState state, int index) {
    if (state is ShowMangas) {
      return LibraryListMangaItem(state.mangas[index]);
    } else if (state is ShowChapters) {
      return LibraryListChapterItem(state.manga, index);
    } else if (state is ShowPages) {
      return LibraryListPageItem(
        state.manga.chapters[state.chapterIndex].pagesPath,
        index,
      );
    } else {
      throw Exception("In LibraryList with state: $state");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryShowState) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _getItemCount(state),
            itemBuilder: (BuildContext ctx, index) {
              return _getItem(state, index);
            },
          );
        } else {
          throw Exception("In LibraryList with state: $state");
        }
      },
    );
  }
}
