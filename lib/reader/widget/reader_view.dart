import "dart:io";
import "package:cross_reader/reader/bloc/reader_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// the reader page main content
class ReaderView extends StatelessWidget {
  /// the reader page main content
  const ReaderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderBloc, ReaderState>(
      builder: (context, state) {
        return SizedBox.expand(
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                // swip left
                BlocProvider.of<ReaderBloc>(context)
                    .add(const ReaderNextEvent());
              } else if (details.primaryVelocity! < 0) {
                // swip right
                BlocProvider.of<ReaderBloc>(context)
                    .add(const ReaderPreviousEvent());
              }
            },
            child: Image.file(File(state.currentPage)),
          ),
        );
      },
    );
  }
}
