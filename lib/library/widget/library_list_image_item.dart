import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cross_reader/reader/model/reader_arguments.dart';

class LibraryListImageItem extends StatelessWidget {
  final List<File> _files;
  final int _index;
  const LibraryListImageItem(this._files, this._index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/reader', arguments: ReaderArguments(_files, _index));
      },
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              _files[_index],
              fit: BoxFit.contain,
            )),
            Text(_index.toString())
          ])),
    );
  }
}
