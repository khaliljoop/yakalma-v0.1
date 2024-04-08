import 'package:yakalma/widgets/app_bar/custom_app_bar.dart';
import 'package:yakalma/widgets/app_bar/appbar_leading_image.dart';
import 'package:yakalma/widgets/app_bar/appbar_title.dart';
import 'package:yakalma/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/sixtyeight_item_widget.dart';
import 'widgets/fiftynine_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:yakalma/core/app_export.dart';

class CateringMenuScreen extends StatelessWidget {
  const CateringMenuScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 16.v),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.v),
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Main Course",
                    style: CustomTextStyles.titleMediumWhiteA70018,
                  ),
                  SizedBox(height: 17.v),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSixtyEight(context),
                      SizedBox(height: 22.v),
                      Text(
                        "Dessert",
                        style: CustomTextStyles.titleMediumWhiteA70018,
                      ),
                      SizedBox(height: 17.v),
                      _buildFiftyNine(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft3,
        margin: EdgeInsets.only(
          left: 30.h,
          top: 15.v,
          bottom: 16.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Huias Food",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilter2,
          margin: EdgeInsets.fromLTRB(30.h, 18.v, 30.h, 19.v),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSixtyEight(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 16.v,
        );
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        return SixtyeightItemWidget();
      },
    );
  }

  /// Section Widget
  Widget _buildFiftyNine(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 16.v,
        );
      },
      itemCount: 2,
      itemBuilder: (context, index) {
        return FiftynineItemWidget();
      },
    );
  }
}
