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
        color: Color(0XFF0961F5),
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
        color: Color(0XFF0961F5),
        fontWeight: FontWeight.w800,
      );
  static get titleSmallff545454 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF545454),
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
}
