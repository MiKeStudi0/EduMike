import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelLargeGray800 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray800,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w700,
      );

    // Label text style Home
  static get labelLargeMulish => theme.textTheme.labelLarge!.mulish.copyWith(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w800,
      );

  // Title text style
  static get titleLargeMulishGray800 =>
      theme.textTheme.titleLarge!.mulish.copyWith(
        color: appTheme.gray800,
        fontWeight: FontWeight.w800,
      );
  static get titleMediumGray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray700,
        fontSize: 16.fSize,
      );
  static get titleMediumJostOnError =>
      theme.textTheme.titleMedium!.jost.copyWith(
        color: theme.colorScheme.onError,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumJostOnErrorContainer =>
      theme.textTheme.titleMedium!.jost.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 19.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumff0961f5 => theme.textTheme.titleMedium!.copyWith(
        color: const Color(0XFF0961F5),
        fontSize: 17.fSize,
      );
  static get titleSmallExtraBold => theme.textTheme.titleSmall!.copyWith(
        fontSize: 15.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallExtraBold_1 => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w800,
      );
  static get titleSmallGray800 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray800,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
      );
  static get titleSmallff0961f5 => theme.textTheme.titleSmall!.copyWith(
        color: const Color(0XFF0961F5),
        fontWeight: FontWeight.w800,
      );
  static get titleSmallff545454 => theme.textTheme.titleSmall!.copyWith(
        color: const Color(0XFF545454),
      );

  static get labelLargeMulishBold =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get labelLargeMulishGray200 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.gray200,
        fontWeight: FontWeight.w800,
      );
  static get labelLargeMulishOrangeA700 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.orangeA700,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeMulishPrimary =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w800,
      );
  static get labelLargeMulishSecondaryContainer =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.8),
        fontWeight: FontWeight.w700,
      );
  static get labelLargeMulishSecondaryContainerBold =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeMulishWhiteA700 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumWhiteA700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelSmallPrimary => theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  // Title text style
  static get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
  static get titleLargeMulishAmberA200 =>
      theme.textTheme.titleLarge!.mulish.copyWith(
        color: appTheme.amberA200,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMedium19 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 19.fSize,
      );
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMontserratBluegray900 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMulishBluegray200 =>
      theme.textTheme.titleMedium!.mulish.copyWith(
        color: appTheme.blueGray200,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 19.fSize,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBluegray90001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallBluegray9000115 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 15.fSize,
      );
  static get titleSmallBluegray90001_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90001.withOpacity(0.8),
      );
  static get titleSmallGray500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray500,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallGray50015 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray500,
        fontSize: 15.fSize,
      );

  static get titleSmallGray80001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray80001,
        fontSize: 15.fSize,
      );
  static get titleSmallJostBluegray90001 =>
      theme.textTheme.titleSmall!.jost.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallJostBluegray90001SemiBold =>
      theme.textTheme.titleSmall!.jost.copyWith(
        color: appTheme.blueGray90001,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallJostWhiteA700 =>
      theme.textTheme.titleSmall!.jost.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallJostff00acea =>
      theme.textTheme.titleSmall!.jost.copyWith(
        color: const Color(0XFF00ACEA),
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallJostff202244 =>
      theme.textTheme.titleSmall!.jost.copyWith(
        color: const Color(0XFF202244),
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );

  static get titleSmallPrimaryExtraBold => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w800,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w800,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get jost {
    return copyWith(
      fontFamily: 'Jost',
    );
  }

  TextStyle get mulish {
    return copyWith(
      fontFamily: 'Mulish',
    );
  }

  TextStyle get aubrey {
    return copyWith(
      fontFamily: 'Aubrey',
    );
  }
    TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
}
