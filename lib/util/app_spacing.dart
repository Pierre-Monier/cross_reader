import "package:flutter/material.dart";

/// the app spacing related data
abstract class AppSpacing {
  /// app radius
  static const Radius appRadius = Radius.circular(10);

  static const double _smallSpace = 8;
  static const double _mediumSpace = 16;
  static const double _largeSpace = 32;
  static const double _veryLargeSpace = 64;

  /// small vertical space
  static const smallVerticalSpace = SizedBox(height: _smallSpace);

  /// small horizontal space
  static const smallHorizontalSpace = SizedBox(width: _smallSpace);

  /// medium vertical space
  static const mediumVerticalSpace = SizedBox(height: _mediumSpace);

  /// medium horizontal space
  static const mediumHorizontalSpace = SizedBox(width: _mediumSpace);

  /// large vertical space
  static const largeVerticalSpace = SizedBox(height: _largeSpace);

  /// large horizontal space
  static const largeHorizontalSpace = SizedBox(width: _largeSpace);

  /// very large vertical space
  static const veryLargeVerticalSpace = SizedBox(height: _veryLargeSpace);

  /// very large horizontal space
  static const veryLargeHorizontalSpace = SizedBox(width: _veryLargeSpace);

  /// small padding
  static const smallPadding = EdgeInsets.all(_smallSpace);

  /// medium padding
  static const mediumPadding = EdgeInsets.all(_mediumSpace);

  /// large padding
  static const largePadding = EdgeInsets.all(_largeSpace);

  /// very large padding
  static const veryLargePadding = EdgeInsets.all(_veryLargeSpace);
}
