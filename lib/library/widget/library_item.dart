import "dart:io";
import "package:flutter/material.dart";

/// Use to display item (manga or chapter or page)
class LibraryItem extends StatelessWidget {
  /// Use to display item (manga or chapter or page)
  const LibraryItem({
    required this.onTap,
    required this.imagePath,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Called when the user taps the item.
  final VoidCallback onTap;

  /// The path to the image to display.
  final String imagePath;

  /// The rest of the data to display
  /// below the image.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: [
                  Expanded(
                    child: Image.file(
                      File(imagePath),
                      width: constrains.maxWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
