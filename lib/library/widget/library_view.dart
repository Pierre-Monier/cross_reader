import 'package:cross_reader/library/bloc/library_bloc.dart';
import 'package:cross_reader/library/widget/library_list.dart';
import 'package:cross_reader/library/widget/library_list_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryShowState && state.isEmpty) {
          return const LibraryListEmpty();
        } else if (state is LibraryShowState) {
          return const LibraryList();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
