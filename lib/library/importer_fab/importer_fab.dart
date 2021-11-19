import 'dart:io';

import 'package:cross_reader/service/file_picker_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/library_bloc.dart';

class ImporterFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // TODO service should be used by BLOC
        Directory? selectedDir =
            await GetIt.I.get<FilePickerWrapper>().getDirectory();

        // if seledDirPath is null, that means the user as canceled the selection
        if (selectedDir != null) {
          BlocProvider.of<LibraryBloc>(context).add(
            Import(selectedDir),
          );
        }
      },
      child: Icon(Icons.add),
    );
  }
}
