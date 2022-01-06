import "package:flutter/material.dart";

/// Widget to show when there is nothing in the library
class LibraryListEmpty extends StatelessWidget {
  /// Widget to show when there is nothing in the library
  const LibraryListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Empty");
  }
}
