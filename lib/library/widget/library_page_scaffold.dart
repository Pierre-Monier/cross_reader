import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/importer_fab/importer_fab.dart';
import 'package:cross_reader/library/widget/library_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO print data on toolbar : Mangas
// If in ShowChapter state : Mangas > MangaName
class LibraryPageScaffold extends StatelessWidget {
  Future<bool> _onWillPop(
      BuildContext context, LibraryState currentState) async {
    if (currentState is ShowChapters) {
      BlocProvider.of<LibraryBloc>(context).add(ListMangas());
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
            body: LibraryView(),
            floatingActionButton: ImporterFab(),
          ));
    });
  }
}

      // return WillPopScope(
      //     child: Scaffold(
      //         appBar: AppBar(
      //           title: Text('Library'),
      //         ),
      //         body: LibraryView(),
      //         floatingActionButton: ImporterFab()),
      //     onWillPop: _onWillPop(context, state))