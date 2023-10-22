import 'package:flutter/material.dart';
import 'package:parking_lot_system/utils/responsive_utils.dart';
import 'package:parking_lot_system/utils/theme.dart';

class SnackBarWidget {
  SnackBar errorSnackBar(String message, BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: ResponsiveUtils.textScaleFactor(context) * 16,
          color: ColorTheme.errorTextColor,
        ),
      ),
      backgroundColor: ColorTheme.errorBGColor,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
