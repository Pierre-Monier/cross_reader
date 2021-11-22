import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/library_bloc.dart';

class ImporterFab extends StatelessWidget {
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
