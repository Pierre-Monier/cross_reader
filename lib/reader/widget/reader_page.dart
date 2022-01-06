import "package:cross_reader/reader/bloc/reader_cubit.dart";
import "package:cross_reader/reader/widget/reader_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// the reader page
class ReaderPage extends StatelessWidget {
  /// the reader page
  const ReaderPage(this._readerCubit, {Key? key}) : super(key: key);
  final ReaderCubit _readerCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _readerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reader"),
        ),
        body: const ReaderView(),
      ),
    );
  }
}
