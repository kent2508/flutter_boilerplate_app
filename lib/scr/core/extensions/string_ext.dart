import 'package:vpb_flutter_boilerplate/scr/core/language/app_translate.dart';

extension ExtendedString on String {
  String mergeURLWithParam(Map<String, dynamic> params) {
    var _url = this;
    if (params.isNotEmpty && !_url.contains('?')) {
      _url += '?';
      params.forEach((String key, dynamic value) {
        _url += '$key=$value&';
      });
      _url.substring(0, _url.length - 1); // remove the '&' at the end of url
    }
    return _url;
  }

  String get localized {
    return AppTranslate.translate(this);
  }
}
