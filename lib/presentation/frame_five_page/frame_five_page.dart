import 'package:yakalma/widgets/custom_search_view.dart';
import 'widgets/framefive_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FrameFivePage extends StatelessWidget {
  FrameFivePage({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildMegaphone(context),
                SizedBox(height: 54.v),
                _buildSearch(context),
                SizedBox(height: 51.v),
                _buildFrameFive(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMegaphone(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 9.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgMegaphone,
              height: 20.v,
              margin: EdgeInsets.only(
                top: 34.v,
                bottom: 65.v,
              ),
            ),
            Spacer(),
            Container(
              width: 161.h,
              margin: EdgeInsets.only(top: 23.v),
              child: Text(
                "Hello \nCheikhou!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: theme.textTheme.headlineLarge!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            Container(
              height: 116.adaptSize,
              width: 116.adaptSize,
              margin: EdgeInsets.only(
                left: 17.h,
                bottom: 3.v,
              ),
              decoration: BoxDecoration(
                color: appTheme.cyan10001,
                borderRadius: BorderRadius.circular(
                  58.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearch(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 3.h,
          right: 15.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomSearchView(
                controller: searchController,
                hintText: "Search",
                hintStyle: theme.textTheme.bodyMedium!,
                contentPadding: EdgeInsets.only(
                  top: 9.v,
                  right: 30.h,
                  bottom: 9.v,
                ),
                borderDecoration: SearchViewStyleHelper.outlinePrimary,
                fillColor: appTheme.cyan10001,
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame9,
              width: 31.h,
              margin: EdgeInsets.only(left: 6.h),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameFive(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 4.h,
          right: 10.h,
        ),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 23.v,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return FramefiveItemWidget();
          },
        ),
      ),
    );
  }
}
