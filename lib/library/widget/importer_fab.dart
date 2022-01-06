import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// FAB button use to import `Manga` in the library
class ImporterFab extends StatelessWidget {
  /// FAB button use to import `Manga` in the library
  const ImporterFab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<LibraryBloc>(context).add(
          Import(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
