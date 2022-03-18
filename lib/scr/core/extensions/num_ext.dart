import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';

extension ExtendedNumber on num {
  double getProportionateScreenSize() {
    return (this / 414.0) * SizeConfig.screenWidth;
  }

  double get proportionateScreenSize {
    return (this / 414.0) * SizeConfig.screenWidth;
  }
}
