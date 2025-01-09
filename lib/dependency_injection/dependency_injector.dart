import 'package:core_dependencies_global/core_dependencies_global.dart';
import 'package:core_dependencies_global/services/image_picker/image_picker_service.dart';
import 'package:core_dependencies_global/services/navigation/i_navigation_service.dart';
import 'package:core_dependencies_global/services/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';

class DependencyInjector {
  DependencyInjector._internal();
  static final DependencyInjector _singleton = DependencyInjector._internal();
  factory DependencyInjector() => _singleton;

  Map<Type, dynamic> _dependencies = {};

  // Services
  GlobalKey<NavigatorState> get navigatorKey =>
      _dependencies[GlobalKey<NavigatorState>] ??= GlobalKey<NavigatorState>();
  NavigationService get navigationService =>
      _dependencies[INavigationService] ??= INavigationService(navigatorKey);
  ImagePickerService get imagePickerService =>
      _dependencies[ImagePickerService] ??= ImagePickerServiceImpl();
}
