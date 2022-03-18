import 'dart:ui';

mixin LocaleManager {
  static List<Locale> validateLocales() => const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ];
  static Locale defaultLocale() => const Locale('vi', 'VN');
}
