import 'widgets/foodcateringdetails_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

class FoodCateringDetailsScreen extends StatelessWidget {
  const FoodCateringDetailsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        body: SizedBox(
          width: 375.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildCover(context),
                SizedBox(height: 14.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.h),
                    child: Text(
                      "Huias Food",
                      style: CustomTextStyles.titleMediumWhiteA70018,
                    ),
                  ),
                ),
                SizedBox(height: 10.v),
                Container(
                  width: 312.h,
                  margin: EdgeInsets.only(
                    left: 30.h,
                    right: 32.h,
                  ),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut laoreet eu arcu vitae bibendum. Nam quam est, facilisis ac tortor ut, volutpat malesuada risus.",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallWhiteA700.copyWith(
                      height: 1.50,
                    ),
                  ),
                ),
                SizedBox(height: 21.v),
                _buildFortyFour(context),
                SizedBox(height: 17.v),
                _buildFoodCateringDetails(context),
                SizedBox(height: 35.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCover(BuildContext context) {
    return SizedBox(
      height: 292.v,
      width: 375.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgCover,
            height: 242.v,
            alignment: Alignment.topCenter,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCover,
            height: 99.adaptSize,
            width: 99.adaptSize,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 30.h),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFortyFour(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Food Menu",
            style: CustomTextStyles.titleMediumWhiteA70018,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.v),
            child: Text(
              "See all",
              style: CustomTextStyles.bodySmallWhiteA700,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFoodCateringDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 14.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return FoodcateringdetailsItemWidget();
        },
      ),
    );
  }
}
