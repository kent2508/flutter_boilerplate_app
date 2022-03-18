import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ThemeManager {
  factory ThemeManager() {
    return shared;
  }
  ThemeManager._internal();
  static ThemeManager shared = ThemeManager._internal();

  Map<String, dynamic>? lightColorHexString;
  Map<String, dynamic>? darkColorHexString;

  Future<void> readJson({Function? completion}) async {
    final String lightData =
        await rootBundle.loadString('assets/themes/light.json');
    final Map<String, dynamic> lightDataJson = await json.decode(lightData);
    lightColorHexString = lightDataJson['colors'];

    final String darkData =
        await rootBundle.loadString('assets/themes/dark.json');

    final Map<String, dynamic> darkDataJson = await json.decode(darkData);
    darkColorHexString = darkDataJson['colors'];

    if (completion != null) {
      completion();
    }
  }
}
