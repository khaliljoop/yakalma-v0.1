import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

// ignore: must_be_immutable
class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
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
              ),

              SizedBox(height: 7.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "Honse Food",
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
  }
}
