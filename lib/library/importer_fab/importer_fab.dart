import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/library_bloc.dart';

class ImporterFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<LibraryBloc>(context).add(
          Import(),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
