import 'package:yakalma/presentation/frame_five_page/frame_five_page.dart';
import 'package:yakalma/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FrameFiveContainerScreen extends StatelessWidget {
  FrameFiveContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.frameFivePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Location:
        return "/";
      case BottomBarEnum.Mobile:
        return "/";
      case BottomBarEnum.Heartssymbolprimary:
        return "/";
      case BottomBarEnum.Cart:
        return AppRoutes.frameFivePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.frameFivePage:
        return FrameFivePage();
      default:
        return DefaultWidget();
    }
  }
}
