import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/scr/core/extensions/color_ext.dart';
import 'theme_manager.dart';

enum ThemeColors {
  primaryColor,
  secondaryColor,
  backgroundColor1,
  backgroundColor2,
  mainTextColor,
  subTextColor,
  divider1,
  divider2,
  success,
  error,
  warning,
}

extension ExtendedThemeColors on ThemeColors {
  String get keyName {
    switch (this) {
      case ThemeColors.primaryColor:
        return 'g_main_color';
      case ThemeColors.secondaryColor:
        return 'g_secondary_color';
      case ThemeColors.backgroundColor1:
        return 'g_main_bg_1';
      case ThemeColors.backgroundColor2:
        return 'g_main_bg_2';
      case ThemeColors.mainTextColor:
        return 'g_main_text';
      case ThemeColors.subTextColor:
        return 'g_sub_text_1';
      case ThemeColors.divider1:
        return 'g_divider_1';
      case ThemeColors.divider2:
        return 'g_divider_2';
      case ThemeColors.success:
        return 'g_success';
      case ThemeColors.error:
        return 'g_error';
      case ThemeColors.warning:
        return 'g_warning';
      default:
        return 'g_main_color';
    }
  }

  Color get lightColor {
    return HexColor.fromHex(ThemeManager().lightColorHexString![keyName]);
  }

  Color get darkColor {
    return HexColor.fromHex(ThemeManager().darkColorHexString![keyName]);
  }
}
