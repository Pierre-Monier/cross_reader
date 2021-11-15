import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

MaterialApp withMaterialAppAndWidgetAncestorAndBlocProvider<T extends Bloc>(
    Widget widget, T bloc) {
  return MaterialApp(
    home: BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: widget,
      ),
    ),
  );
}
