import "package:cross_reader/reader/bloc/reader_bloc.dart";
import "package:cross_reader/reader/widget/reader_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// the reader page
class ReaderPage extends StatelessWidget {
  /// the reader page
  const ReaderPage({
    Key? key,
    required ReaderBloc readerBloc,
  })  : _readerBloc = readerBloc,
        super(key: key);

  /// route name of the page
  static const routeName = "/reader";
  final ReaderBloc _readerBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _readerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reader"),
        ),
        body: const ReaderView(),
      ),
    );
  }
}
