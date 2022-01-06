import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/importer_fab.dart";
import "package:cross_reader/library/widget/library_appbar.dart";
import "package:cross_reader/library/widget/library_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// Scaffold for the library page
class LibraryPageScaffold extends StatelessWidget {
  /// Scaffold for the library page
  const LibraryPageScaffold({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context, LibraryState state) async {
    if (state is ShowChapters) {
      BlocProvider.of<LibraryBloc>(context).add(ListMangas());
      return false;
    } else if (state is ShowPages) {
      BlocProvider.of<LibraryBloc>(context)
          .add(ListChapters(state.manga.chapters, state.manga));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => _onWillPop(context, state),
          child: const Scaffold(
            appBar: LibraryAppBar(),
            body: LibraryView(),
            floatingActionButton: ImporterFab(),
          ),
        );
      },
    );
  }
}
