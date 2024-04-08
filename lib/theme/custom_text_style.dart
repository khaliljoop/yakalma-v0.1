import 'package:flutter/material.dart';
import 'package:yakalma/core/utils/size_utils.dart';
import 'package:yakalma/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.5),
        fontWeight: FontWeight.w300,
      );
  static get bodySmallCyan10001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.cyan10001,
      );
  static get bodySmallCyan800 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.cyan800,
      );
  static get bodySmallOnPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 12.fSize,
      );
  static get bodySmallOnPrimaryContainer_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 12.fSize,
      );
  static get bodySmallWhiteA700_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700,
      );
  // Display style
  static get displayMediumPlusJakartaSans =>
      theme.textTheme.displayMedium!.plusJakartaSans;
  static get displayMediumPlusJakartaSansTeal400 =>
      theme.textTheme.displayMedium!.plusJakartaSans.copyWith(
        color: appTheme.teal400,
        fontSize: 48.fSize,
      );
  static get displayMediumPlusJakartaSansWhiteA700 =>
      theme.textTheme.displayMedium!.plusJakartaSans.copyWith(
        color: appTheme.whiteA700,
        fontSize: 48.fSize,
      );
  // Headline text style
  static get headlineLargeDeeporange900 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.deepOrange900,
      );
  static get headlineLargeInterOrange800 =>
      theme.textTheme.headlineLarge!.inter.copyWith(
        color: appTheme.orange800,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallInterDeeporange700 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.deepOrange700,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallInterDeeporange70001 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.deepOrange70001,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallInterDeeporange70002 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.deepOrange70002,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallInterPrimaryContainer =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallOrange80001 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.orange80001,
      );
  static get headlineSmallTeal400 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.teal400,
      );
  // Label text style
  static get labelLargeInterWhiteA700 =>
      theme.textTheme.labelLarge!.inter.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeTeal400 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.teal400,
        fontSize: 13.fSize,
      );
  static get labelLargeTeal40013 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.teal400,
        fontSize: 13.fSize,
      );
  static get labelLargeWhiteA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelLargeffffffff => theme.textTheme.labelLarge!.copyWith(
        color: Color(0XFFFFFFFF),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeffffffffMedium => theme.textTheme.labelLarge!.copyWith(
        color: Color(0XFFFFFFFF),
        fontWeight: FontWeight.w500,
      );
  // Plus text style
  static get plusJakartaSansTeal400 => TextStyle(
        color: appTheme.teal400,
        fontSize: 96.fSize,
        fontWeight: FontWeight.w700,
      ).plusJakartaSans;
  // Title text style
  static get titleLargeCyan800 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.cyan800,
      );
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
      );
  static get titleLargeWhiteA700 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleLargeWhiteA70022 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 22.fSize,
      );
  static get titleMediumCyan10001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.cyan10001,
      );
  static get titleMediumInterPrimaryContainer =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterTeal400 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.teal400,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleMediumWhiteA70018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
      );
  static get titleMediumWhiteA700_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumWhiteA700_2 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleSmallTeal300 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal300,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallTeal400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal400,
        fontWeight: FontWeight.w700,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get plusJakartaSans {
    return copyWith(
      fontFamily: 'Plus Jakarta Sans',
    );
  }
}
