import "package:cross_reader/library/bloc/backup_bloc.dart";
import "package:cross_reader/library/bloc/library_bloc.dart";
import "package:cross_reader/library/widget/backup_failed_dialog.dart";
import "package:cross_reader/library/widget/backup_loading_dialog.dart";
import "package:cross_reader/library/widget/backup_success_dialog.dart";
import "package:cross_reader/library/widget/library_page_scaffold.dart";
import "package:cross_reader/model/last_readed.dart";
import "package:cross_reader/model/manga.dart";
import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:cross_reader/reader/widget/reader_page.dart";
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

  void _showMangaLastReadMaterialBanner(BuildContext context, Manga manga) {
    final materialBanner = MaterialBanner(
      content: const Text("Retourner la ou vous vous êtes arreter ?"),
      actions: [
        TextButton(
          child: const Text("Oui"),
          onPressed: () {
            ScaffoldMessenger.of(context).clearMaterialBanners();
            Navigator.of(context).pushNamed(
              ReaderPage.routeName,
              arguments: ReaderArguments(
                manga: manga,
                chapterIndex: manga.lastReaded.chapterIndex,
                pageIndex: manga.lastReaded.pageIndex,
              ),
            );
          },
        ),
        TextButton(
          child: const Text("Non"),
          onPressed: () {
            ScaffoldMessenger.of(context).clearMaterialBanners();
          },
        ),
      ],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
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
                  _showMangaLastReadMaterialBanner(context, state.manga);
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
