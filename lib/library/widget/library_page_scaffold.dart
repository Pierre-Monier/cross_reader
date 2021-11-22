import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/importer_fab/importer_fab.dart';
import 'package:cross_reader/library/widget/library_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO print data on toolbar : Mangas
// If in ShowChapter state : Mangas > MangaName
class LibraryPageScaffold extends StatelessWidget {
  const LibraryPageScaffold({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context, LibraryState state) async {
    if (state is ShowChapters) {
      BlocProvider.of<LibraryBloc>(context).add(ListMangas());
      return false;
    } else if (state is ShowImages) {
      BlocProvider.of<LibraryBloc>(context)
          .add(ListChapters(state.manga.chapters, state.manga));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      return WillPopScope(
          onWillPop: () => _onWillPop(context, state),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Library'),
            ),
            body: const LibraryView(),
            floatingActionButton: const ImporterFab(),
          ));
    });
  }
}
