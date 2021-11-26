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

  int _getItemCount(LibraryState state) {
    if (state is ShowMangas) {
      return GetIt.I.get<MangaRepository>().mangaList.length;
    } else if (state is ShowChapters) {
      return state.manga.chapters.length;
    } else if (state is ShowImages) {
      return state.manga.chapters[state.chapterIndex].imagesPath.length;
    } else {
      return 0;
    }
  }

  Widget _getItem(LibraryState state, int index) {
    if (state is ShowMangas) {
      return LibraryListMangaItem(state.mangas[index]);
    } else if (state is ShowChapters) {
      return LibraryListChapterItem(state.manga, index);
    } else if (state is ShowImages) {
      return LibraryListImageItem(
          state.manga.chapters[state.chapterIndex].imagesPath, index);
    } else {
      throw Exception('In LibraryList with state: $state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is LibraryShowState) {
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
        throw Exception('In LibraryList with state: $state');
      }
    });
  }
}
