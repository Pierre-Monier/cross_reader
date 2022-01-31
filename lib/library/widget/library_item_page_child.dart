import "package:cross_reader/util/app_style.dart";
import "package:flutter/material.dart";

/// The child for a displayed page.
class LibraryItemPageChild extends StatelessWidget {
  /// The child for a displayed page.
  const LibraryItemPageChild({required this.pageName, Key? key})
      : super(key: key);

  /// The name of the page.
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        pageName,
        style: AppStyle.libraryItemTitle,
        textAlign: TextAlign.start,
      ),
    );
  }
}
