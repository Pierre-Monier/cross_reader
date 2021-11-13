import 'package:flutter/material.dart';

MaterialApp withMaterialApp(Widget widget) {
  return MaterialApp(
    home: widget,
  );
}

MaterialApp withMaterialAppAndWidgetAncestor(Widget widget) {
  return MaterialApp(
    home: Scaffold(
      body: widget,
    ),
  );
}
