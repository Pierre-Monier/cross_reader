import "package:cross_reader/library/bloc/backup_bloc.dart";
import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/backup_failed_dialog.dart";
import "package:cross_reader/library/widget/backup_loading_dialog.dart";
import "package:cross_reader/library/widget/backup_success_dialog.dart";
import "package:cross_reader/library/widget/library_page_scaffold.dart";
import 'package:cross_reader/model/manga.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// The library page.
class LibraryPage extends StatelessWidget {
  /// The library page.
  const LibraryPage({
    required LibraryBloc libraryBloc,
    required BackupBloc backupBloc,
    Key? key,
  })  : _libraryBloc = libraryBloc,
        _backupBloc = backupBloc,
        super(key: key);

  /// route name of the page
  static const routeName = "/library";
  final LibraryBloc _libraryBloc;
  final BackupBloc _backupBloc;

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showBackupDialog(BuildContext context, Widget dialog) =>
      showDialog<Widget>(
        context: context,
        builder: (context) {
          return dialog;
        },
      );

  void _showMangaLastReadSnackbar(BuildContext context, Manga manga) {
    final snackBar = SnackBar(
        content: Text("Reprendre ${manga.name} au chapitre "
            " ${manga.lastReaded.chapterIndex} page ${manga.lastReaded.pageIndex}"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LibraryBloc>(create: (context) => _libraryBloc),
        BlocProvider<BackupBloc>(create: (context) => _backupBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LibraryBloc, LibraryState>(
            listener: (context, state) {
              if (state is ImportFailed) {
                _showSnackBar(context, "FAILED");
              } else if (state is ImportSucceed) {
                _showSnackBar(context, "SUCCESS");
              } else if (state is ShowChapters) {
                if (state.manga.lastReaded != LastReaded.defaultValue()) {
                  _showMangaLastReadSnackbar(context, state.manga);
                }
              }
            },
          ),
          BlocListener<BackupBloc, BackupState>(
            listener: (context, state) {
              if (state is BackupSuccess) {
                _showBackupDialog(context, const BackupSuccessDialog());
              } else if (state is BackupFailed) {
                _showBackupDialog(context, const BackupFailedDialog());
              } else if (state is BackupLoading) {
                _showBackupDialog(context, const BackupLoadingDialog());
              }
            },
          ),
        ],
        child: const LibraryPageScaffold(),
      ),
    );
  }
}
