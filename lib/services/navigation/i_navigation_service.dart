import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'navigation_service.dart';

class INavigationService implements NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey;
  INavigationService(this._navigatorKey);

  @override
  Future<dynamic> pushNamed(String routeName, {Object? args}) {
    return _navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  @override
  void pop() {
    _navigatorKey.currentState!.pop();
  }

  @override
  Future<dynamic> pushReplacement(String routeName, {Object? args}) {
    return _navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: args);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? args,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (_) => false,
      arguments: args,
    );
  }

  @override
  Future pushScreen(Widget screen ,{PageTransitionType? type}) {
    return _navigatorKey.currentState!.push(
      PageTransition(
        type:type?? PageTransitionType.leftToRight,
        child: screen,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
