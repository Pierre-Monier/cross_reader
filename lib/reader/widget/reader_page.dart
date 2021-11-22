import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/reader_cubit.dart';
import './reader_view.dart';

class ReaderPage extends StatelessWidget {
  final ReaderCubit _readerCubit;

  const ReaderPage(this._readerCubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _readerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reader'),
        ),
        body: const ReaderView(),
      ),
    );
  }
}
