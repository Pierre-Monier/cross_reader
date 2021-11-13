import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list.dart';
import 'package:cross_reader/library/widget/library_list_empty.dart';
import 'package:cross_reader/repository/manga_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is ImportStarted) {
          return CircularProgressIndicator();
        }

        if (GetIt.I<MangaRepository>().mangaList.isEmpty) {
          return LibraryListEmpty();
        } else {
          return LibraryList();
        }
      },
    );
  }
}
