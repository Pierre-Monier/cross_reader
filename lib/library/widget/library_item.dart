import "dart:io";
import "package:flutter/material.dart";

/// Use to display item (manga or chapter or page)
class LibraryItem extends StatelessWidget {
  /// Use to display item (manga or chapter or page)
  const LibraryItem({
    required this.onTap,
    required this.imagePath,
    required this.text,
    Key? key,
  }) : super(key: key);

  /// Called when the user taps the item.
  final VoidCallback onTap;

  /// The path to the image to display.
  final String imagePath;

  /// The text to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
