import "package:cross_reader/library/bloc/backup_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// AppBar of the library page.
class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// AppBar of the library page.
  const LibraryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Library"),
      actions: [
        PopupMenuButton<PopupMenuItem>(
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<PopupMenuItem>>[
            PopupMenuItem(
              child: IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.black26,
                ),
                onPressed: () {
                  BlocProvider.of<BackupBloc>(context).add(BackupLibrary());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
