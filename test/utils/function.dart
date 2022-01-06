import "package:flutter/material.dart" hide State;
import "package:flutter_bloc/flutter_bloc.dart";

MaterialApp withMaterialApp(Widget widget) {
  return MaterialApp(
    home: widget,
  );
}

MaterialApp withMaterialAppAndNavigatorKey(
  Widget widget,
  GlobalKey<NavigatorState> key,
) {
  return MaterialApp(
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

MaterialApp
    withMaterialAppAndWidgetAncestorAndNavigatorObserverAndRouteGenerator(
  Widget widget,
  NavigatorObserver observer,
) {
  return MaterialApp(
    navigatorObservers: [observer],
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case "/reader":
          return MaterialPageRoute<Scaffold>(
            builder: (context) => Scaffold(
              body: widget,
            ),
          );
        default:
          return MaterialPageRoute<Scaffold>(
            builder: (context) => Scaffold(
              body: widget,
            ),
          );
      }
    },
    home: Scaffold(
      body: widget,
    ),
  );
}

MaterialApp withMaterialAppAndWidgetAncestorAndBlocProvider<
    T extends Bloc<Object, Object>>(
  Widget widget,
  T bloc,
) {
  return MaterialApp(
    home: BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        body: widget,
      ),
    ),
  );
}

Future<void> withDebounce(Function() callback) async {
  await Future.delayed(const Duration(milliseconds: 300), () {});

  callback();
}
