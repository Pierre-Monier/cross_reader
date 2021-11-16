import 'dart:io';
import 'package:cross_reader/reader/bloc/reader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, File>(builder: (context, state) {
      return SizedBox.expand(
          child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  // swip left
                  context.read<ReaderCubit>().previous();
                } else if (details.primaryVelocity! < 0) {
                  // swip right
                  context.read<ReaderCubit>().next();
                }
              },
              child: Image.file(state)));
    });
  }
}
