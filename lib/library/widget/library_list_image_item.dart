import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cross_reader/reader/model/reader_arguments.dart';

class LibraryListImageItem extends StatelessWidget {
  final List<String> _imagesPath;
  final int _index;
  const LibraryListImageItem(this._imagesPath, this._index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/reader',
            arguments: ReaderArguments(_imagesPath, _index));
      },
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              File(_imagesPath[_index]),
              fit: BoxFit.contain,
            )),
            Text(_index.toString())
          ])),
    );
  }
}
