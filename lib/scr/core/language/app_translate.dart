part 'lang_en.dart';
part 'lang_vi.dart';

enum SupportLanguages {
  En,
  Vi,
}

class AppTranslate {
  factory AppTranslate() => _instance;
  AppTranslate._();

  static final _instance = AppTranslate._();

  static late SupportLanguages currentLanguage;
  static late Map<String, String> dataLang;

  static String translate(String keyword) {
    try {
      return dataLang[keyword]!;
    } catch (e) {
      return 'Data not found';
    }
  }

  static void setLanguage(SupportLanguages currentLang) {
    currentLanguage = currentLang;
    if (currentLang == SupportLanguages.Vi) {
      dataLang = vi_VN;
    } else {
      dataLang = en_US;
    }
  }
}
