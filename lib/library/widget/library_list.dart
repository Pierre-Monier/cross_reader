import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/library_item.dart";
import "package:cross_reader/library/widget/library_item_chapter_child.dart";
import "package:cross_reader/library/widget/library_item_manga_child.dart";
import "package:cross_reader/library/widget/library_item_page_child.dart";
import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:cross_reader/reader/widget/reader_page.dart";
import "package:cross_reader/util/app_spacing.dart";
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

  Widget _getItem(BuildContext context, LibraryState state, int index) {
    late String imagePath;
    late Widget child;
    late VoidCallback onTap;

    if (state is ShowMangas) {
      final stateManga = state.mangas[index];

      imagePath = stateManga.chapters[0].pagesPath[0];
      child = LibraryItemMangaChild(
        manga: stateManga,
      );
      onTap = () {
        BlocProvider.of<LibraryBloc>(context).add(
          ListChapters(
            stateManga.chapters,
            stateManga,
          ),
        );
      };
    } else if (state is ShowChapters) {
      final stateManga = state.manga;
      final stateChapter = state.chapters[index];

      imagePath = stateChapter.pagesPath[0];
      child = LibraryItemChapterChild(
        manga: stateManga,
        chapterIndex: index,
      );

      onTap = () {
        BlocProvider.of<LibraryBloc>(context).add(
          ListPages(
            stateChapter.pagesPath,
            stateManga,
            index,
          ),
        );
      };
    } else if (state is ShowPages) {
      final stateManga = state.manga;
      final stateChapterIndex = state.chapterIndex;
      final stateChapter = stateManga.chapters[stateChapterIndex];

      imagePath = stateChapter.pagesPath[index];
      child = LibraryItemPageChild(
        pageName: index.toString(),
      );

      onTap = () {
        Navigator.of(context).pushNamed(
          ReaderPage.routeName,
          arguments: ReaderArguments(
            manga: stateManga,
            chapterIndex: stateChapterIndex,
            pageIndex: index,
          ),
        );
      };
    }

    return LibraryItem(
      imagePath: imagePath,
      onTap: onTap,
      child: Padding(
        padding: AppSpacing.smallPadding,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryShowState) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _getItemCount(state),
            itemBuilder: (BuildContext ctx, index) {
              return _getItem(context, state, index);
            },
          );
        } else {
          throw Exception("In LibraryList with state: $state");
        }
      },
    );
  }
}
