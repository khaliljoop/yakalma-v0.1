import 'package:yakalma/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

// ignore: must_be_immutable
class FramefiveItemWidget extends StatelessWidget {
  const FramefiveItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 9.h,
          vertical: 10.v,
        ),
        decoration: AppDecoration.outlineWhiteA.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64.adaptSize,
              width: 64.adaptSize,
              margin: EdgeInsets.only(bottom: 3.v),
              decoration: BoxDecoration(
                color: appTheme.blueGray100,
                borderRadius: BorderRadius.circular(
                  8.h,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.h,
                top: 8.v,
                bottom: 8.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Goglio Catering",
                    style: CustomTextStyles.titleSmallTeal300,
                  ),
                  SizedBox(height: 1.v),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLocationDeepOrange900,
                        height: 10.adaptSize,
                        width: 10.adaptSize,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "Wolter Kajsa St. 18.",
                          style: CustomTextStyles.bodySmallCyan10001,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.v),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgTimeCircleDeepOrange900,
                        height: 10.adaptSize,
                        width: 10.adaptSize,
                        margin: EdgeInsets.only(bottom: 3.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "12 mins remaining",
                          style: CustomTextStyles.bodySmallCyan10001,
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
                top: 27.v,
                right: 19.h,
                bottom: 12.v,
              ),
              child: CustomIconButton(
                height: 27.adaptSize,
                width: 27.adaptSize,
                padding: EdgeInsets.all(7.h),
                decoration: IconButtonStyleHelper.fillTeal,
                child: CustomImageView(
                  imagePath: ImageConstant.imgDocument,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
