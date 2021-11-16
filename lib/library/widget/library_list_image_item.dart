import 'dart:io';

import 'package:flutter/material.dart';

class LibraryListImageItem extends StatelessWidget {
  final File _file;
  final int _index;
  const LibraryListImageItem(this._file, this._index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("TAPED"),
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              _file,
              fit: BoxFit.contain,
            )),
            Text(_index.toString())
          ])),
    );
  }
}
