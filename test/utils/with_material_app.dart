import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

MaterialApp withMaterialApp(Widget widget) {
  return MaterialApp(
    home: widget,
  );
}

MaterialApp withMaterialAppAndNavigationHistoryObserverAndNavigatorKey(
    Widget widget,
    NavigationHistoryObserver observer,
    GlobalKey<NavigatorState> key) {
  return MaterialApp(
    navigatorObservers: [observer],
    navigatorKey: key,
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
