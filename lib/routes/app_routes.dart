import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/food_catering_details_screen/food_catering_details_screen.dart';
import '../presentation/catering_menu_screen/catering_menu_screen.dart';
import '../presentation/frame_five_container_screen/frame_five_container_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';

  static const String foodCateringDetailsScreen =
      '/food_catering_details_screen';

  static const String cateringMenuScreen = '/catering_menu_screen';

  static const String frameFiveContainerScreen = '/frame_five_container_screen';

  static const String frameFivePage = '/frame_five_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => HomeScreen(),
    foodCateringDetailsScreen: (context) => FoodCateringDetailsScreen(),
    cateringMenuScreen: (context) => CateringMenuScreen(),
    frameFiveContainerScreen: (context) => FrameFiveContainerScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
