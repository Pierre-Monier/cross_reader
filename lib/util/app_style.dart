import "package:cross_reader/util/app_color.dart";
import "package:flutter/material.dart";

/// contains all app text styles
abstract class AppStyle {
  /// title of library items
  static const libraryItemTitle = TextStyle(
    fontSize: 24,
    color: textColor,
  );

  /// other data in library items
  static const libraryItemSubData = TextStyle(fontSize: 14, color: textColor);

  /// readed percentage of library items
  static const librayItemPercentage = TextStyle(
    fontSize: 14,
    color: textColor,
    fontStyle: FontStyle.italic,
  );
}
