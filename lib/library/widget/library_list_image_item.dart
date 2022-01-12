import "dart:io";

import "package:cross_reader/reader/model/reader_arguments.dart";
import "package:flutter/material.dart";

/// A page representation, displayed in page list
class LibraryListPageItem extends StatelessWidget {
  /// A page representation, displayed in page list
  const LibraryListPageItem(this._imagesPath, this._index, {Key? key})
      : super(key: key);
  final List<String> _imagesPath;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          "/reader",
          arguments: ReaderArguments(_imagesPath, _index),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(_imagesPath[_index]),
                fit: BoxFit.contain,
              ),
            ),
            Text(_index.toString())
          ],
        ),
      ),
    );
  }
}
