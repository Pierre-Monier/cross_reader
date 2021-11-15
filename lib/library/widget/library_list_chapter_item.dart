import 'package:cross_reader/model/chapter.dart';
import 'package:flutter/material.dart';

class LibraryListChapterItem extends StatelessWidget {
  final Chapter _chapter;
  const LibraryListChapterItem(this._chapter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("TAPED"),
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
                child: Image.file(
              _chapter.images[0],
              fit: BoxFit.contain,
            )),
            Text(_chapter.name)
          ])),
    );
  }
}
