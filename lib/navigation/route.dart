import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home('/home'),
  favorite('/home/favorite');

  const AppRoute(this.path);
  final String path;
}

extension AppRouteNavigation on AppRoute {
  void go(BuildContext context) => context.go(path);
  void push(BuildContext context, {arg}) => context.push(path,extra: arg);
}
