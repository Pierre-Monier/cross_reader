import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/library_item.dart";
import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:cross_reader/reader/widget/reader_page.dart";
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
    var imagePath = "";
    var text = "";
    var onTap = () {};

    if (state is ShowMangas) {
      final stateManga = state.mangas[index];

      imagePath = stateManga.chapters[0].pagesPath[0];
      text = stateManga.name;
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
      text = stateChapter.name;
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
      text = index.toString();
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
      text: text,
      onTap: onTap,
    );
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
