import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  });

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.gray5001,
                  borderRadius: BorderRadius.circular(26.h),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.black900.withOpacity(0.1),
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: const Offset(
                        1,
                        3,
                      ),
                    ),
                  ],
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlinePrimary => BoxDecoration(
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 0.h,
        ),
      );
  static BoxDecoration get outlineBlackTL26 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(26.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              1,
              3,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineTeal => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(
          color: appTheme.blue600,
          width: 3.h,
        ),
      );
  static BoxDecoration get outlineBlackTL261 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(26.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              1,
              3,
            ),
          ),
        ],
      );
}
