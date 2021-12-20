import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Library'),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            BlocProvider.of<LibraryBloc>(context).add(BackupLibrary());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}