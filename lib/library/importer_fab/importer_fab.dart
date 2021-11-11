import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../bloc/library_bloc.dart';

class ImporterFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String? selectDirPath = await FilePicker.platform.getDirectoryPath();

        // if seledDirPath is null, that means the user as canceled the selection
        if (selectDirPath != null) {
          Directory directory = Directory(selectDirPath);
          BlocProvider.of<LibraryBloc>(context).add(
            Import(directory),
          );
        }
      },
      child: Icon(Icons.add),
    );
  }
}
