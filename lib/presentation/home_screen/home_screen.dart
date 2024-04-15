import 'package:yakalma/models/plat.dart';
import 'package:yakalma/presentation/frame_five_page/frame_five_page.dart';
import 'package:yakalma/services/firebaseService.dart';
import 'package:yakalma/widgets/app_bar/custom_app_bar.dart';
import 'package:yakalma/widgets/app_bar/appbar_leading_image.dart';
import 'package:yakalma/widgets/app_bar/appbar_trailing_image.dart';
import 'package:yakalma/widgets/custom_search_view.dart';
import 'package:yakalma/widgets/custom_elevated_button.dart';
import 'package:yakalma/widgets/custom_icon_button.dart';
import 'widgets/home_item_widget.dart';
import 'package:yakalma/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseService firebaseService=FirebaseService();
  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              SizedBox(height: 15.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 9.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h),
                          child: CustomSearchView(
                            controller: searchController,
                            hintText: "Search",
                            hintStyle:
                                CustomTextStyles.bodySmallOnPrimaryContainer,
                            contentPadding: EdgeInsets.only(
                              top: 14.v,
                              right: 30.h,
                              bottom: 14.v,
                            ),
                            borderDecoration:
                                SearchViewStyleHelper.fillOnPrimary,
                            fillColor: theme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: 26.v),
                        _buildHomeBanner(context),
                        SizedBox(height: 28.v),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h),
                          child: _buildNearYou(
                            context,
                            nearYou: "Your Order",
                            seeAll: "See all",
                          ),
                        ),
                        SizedBox(height: 17.v),
                        _buildPLACEYOURDESIGN(context),
                        SizedBox(height: 28.v),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h),
                          child: _buildNearYou(
                            context,
                            nearYou: "Near You",
                            seeAll: "See all",
                          ),
                        ),
                        SizedBox(height: 17.v),
                        _buildHome(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClock,
        margin: EdgeInsets.only(
          left: 30.h,
          top: 11.v,
          bottom: 11.v,
        ),
      ),
      title: Container(
        width: 85.h,
        margin: EdgeInsets.only(left: 6.h),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Good morning,\n",
                style: CustomTextStyles.labelLargeffffffffMedium,
              ),
              TextSpan(
                text: "Samuel!",
                style: CustomTextStyles.labelLargeffffffff,
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification,
          margin: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 17.v,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildHomeBanner(BuildContext context) {
    return Container(
      width: 315.h,
      margin: EdgeInsets.symmetric(horizontal: 21.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 20.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          SizedBox(
            width: 129.h,
            child: Text(
              "Order Your Food\nFor One Month",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMediumWhiteA700_2.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 9.v),
          TextButton(
              onPressed: (){
                //Navigator.pushNamed(context, AppRoutes.appNavigationScreen);
                //Navigator.pushNamed(context, AppRoutes.cateringMenuScreen);
                //Navigator.pushNamed(context, AppRoutes.foodCateringDetailsScreen);
                Navigator.pushNamed(context, AppRoutes.frameFiveContainerScreen);
                //Navigator.pushNamed(context, AppRoutes.frameFivePage);
              },
              child: Text("go to")
          ),
          CustomElevatedButton(
            width: 101.h,
            text: "Discover Now",
            buttonStyle: CustomButtonStyles.fillDeepOrangeA,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPLACEYOURDESIGN(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 21.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 71.adaptSize,
            width: 71.adaptSize,
            decoration: BoxDecoration(
              color: appTheme.blueGray100,
              borderRadius: BorderRadius.circular(
                8.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 9.v,
              bottom: 7.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Goglio Catreing",
                  style: CustomTextStyles.titleSmallBold,
                ),
                SizedBox(height: 3.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLocationWhiteA700,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "Wolter Kajsa St. 18.",
                        style: CustomTextStyles.bodySmallWhiteA700_1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgTimeCircle,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "12 mins remaining",
                        style: CustomTextStyles.bodySmallWhiteA700_1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 21.v,
              bottom: 20.v,
            ),
            child: CustomIconButton(
              height: 30.adaptSize,
              width: 30.adaptSize,
              padding: EdgeInsets.all(8.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgDocument,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHome(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 146.v,
        child: FutureBuilder(future: firebaseService.getPlats(),
          builder: (BuildContext context, AsyncSnapshot<List<Plat>> plats) {
            switch (plats.connectionState) {
              case ConnectionState.waiting:
                return  Container();
              default:
                if (plats.hasData){
                  if(plats.data!.isNotEmpty){
                    return ListView.separated(
                      padding: EdgeInsets.only(left: 21.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (
                          context,
                          index,
                          ) {
                        return SizedBox(
                          width: 12.h,
                        );
                      },
                      itemCount: plats.data!.length,
                      itemBuilder: (context, index) {
                       // return HomeItemWidget();
                        return SizedBox(
                          width: 104.h,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.all(9.h),
                              decoration: AppDecoration.fillOnPrimary.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 85.v,
                                    width: 84.h,
                                    margin: EdgeInsets.only(left: 1.h),
                                    decoration: BoxDecoration(
                                      color: appTheme.blueGray100,
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),

                                    ),
                                    child: Image.network(plats.data![index].photoUrl),
                                  ),

                                  SizedBox(height: 7.v),
                                  Padding(
                                    padding: EdgeInsets.only(left: 1.h),
                                    child: Text(
                                      //"Honse Food",
                                      plats.data![index].date_plat,
                                      style: CustomTextStyles.labelLargeWhiteA700,
                                    ),
                                  ),
                                  SizedBox(height: 4.v),
                                  Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgLocationWhiteA700,
                                        height: 12.adaptSize,
                                        width: 12.adaptSize,
                                        margin: EdgeInsets.only(bottom: 1.v),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.h),
                                        child: Text(
                                          "1.1 km away",
                                          style: CustomTextStyles.bodySmallWhiteA700_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();

                }
                else {
                  return  Container();
                }
            }

          },
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

  /// Common widget
  Widget _buildNearYou(
    BuildContext context, {
    required String nearYou,
    required String seeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nearYou,
          style: CustomTextStyles.titleMediumWhiteA70018.copyWith(
            color: appTheme.whiteA700,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.v),
          child: Text(
            seeAll,
            style: CustomTextStyles.bodySmallWhiteA700.copyWith(
              color: appTheme.whiteA700,
            ),
          ),
        ),
      ],
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
