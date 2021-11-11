import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/library_bloc.dart';
import '../importer_fab/importer_fab.dart';
import './library_view.dart';

class LibraryPage extends StatelessWidget {
  final LibraryBloc _libraryBloc;
  const LibraryPage(this._libraryBloc, {Key? key}) : super(key: key);

  _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _libraryBloc,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Library'),
            ),
            body: BlocListener<LibraryBloc, LibraryState>(
              listener: (context, state) {
                if (state is ImportFailed) {
                  _showSnackBar(context, "FAILED");
                } else if (state is ImportSucceed) {
                  _showSnackBar(context, "SUCCESS");
                }
              },
              child: LibraryView(),
            ),
            floatingActionButton: ImporterFab()));
  }
}
