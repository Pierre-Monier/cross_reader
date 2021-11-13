import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list_manga_item.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      if (state is ShowMangas) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: GetIt.I.get<MangaRepository>().mangaList.length,
            itemBuilder: (BuildContext ctx, index) {
              return LibraryListMangaItem(
                  GetIt.I.get<MangaRepository>().mangaList[index]);
            });
      } else {
        return Text('TODO');
      }
    });
  }
}
