import 'package:yakalma/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

// ignore: must_be_immutable
class FoodcateringdetailsItemWidget extends StatelessWidget {
  const FoodcateringdetailsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              top: 2.v,
              bottom: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Main Course",
                  style: CustomTextStyles.bodySmallWhiteA700_1,
                ),
                SizedBox(height: 5.v),
                Text(
                  "Veggie Gains",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 6.v),
                Text(
                  "45",
                  style: CustomTextStyles.titleMediumWhiteA700,
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
                imagePath: ImageConstant.imgBuy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
