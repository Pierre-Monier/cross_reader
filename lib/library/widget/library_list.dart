import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list_chapter_item.dart';
import 'package:cross_reader/library/widget/library_list_image_item.dart';
import 'package:cross_reader/library/widget/library_list_manga_item.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key}) : super(key: key);

  int _getItemCount(LibraryState currentState) {
    if (currentState is ShowMangas) {
      return GetIt.I.get<MangaRepository>().mangaList.length;
    } else if (currentState is ShowChapters) {
      return currentState.manga.chapters.length;
    } else if (currentState is ShowImages) {
      return currentState
          .manga.chapters[currentState.chapterIndex].images.length;
    } else {
      return 0;
    }
  }

  Widget _getItem(LibraryState currentState, int index) {
    if (currentState is ShowMangas) {
      return LibraryListMangaItem(
          GetIt.I.get<MangaRepository>().mangaList[index]);
    } else if (currentState is ShowChapters) {
      return LibraryListChapterItem(currentState.manga, index);
    } else if (currentState is ShowImages) {
      return LibraryListImageItem(
          currentState.manga.chapters[currentState.chapterIndex].images, index);
    } else {
      return Text("TODO: error widget");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is ShowMangas || state is ShowChapters || state is ShowImages) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: _getItemCount(state),
            itemBuilder: (BuildContext ctx, index) {
              return _getItem(state, index);
            });
      } else {
        return Text("TODO: error widget");
      }
    });
  }
}
