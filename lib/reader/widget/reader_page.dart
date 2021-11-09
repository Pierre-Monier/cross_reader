import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import './reader_view.dart';

class ReaderPage extends StatelessWidget {
  final List<String> _imagesPaths;

  const ReaderPage(this._imagesPaths, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(_imagesPaths),
      child: ReaderView(),
    );
  }
}
