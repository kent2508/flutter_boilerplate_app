import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';

// * PADDING, HEIGHT, SIZE, RADIUS CONSTANTS
const kValidatorPadding = 20.0;
const kDefaultPadding = 16.0;
const kTopPadding = 8.0;
const kItemPadding = 10.0;

const kButtonHeight = 44.0;

const kCornerRadius = 8.0;

// * GRADIENT
const LinearGradient kGradientBackground = LinearGradient(
  begin: FractionalOffset(0.0, 0.54),
  end: FractionalOffset(0.0, 0.97),
  // ignore: always_specify_types
  colors: [
    Color(0xff9575e8),
    Color(0xff219fd5),
  ],
);

// Get the proportionate height as per screen size
double getProportionateScreenSize(double inputWidth) {
  // 375 is the layout width that designer use
  return (inputWidth / 414.0) * SizeConfig.screenWidth;
}

// * DURATIONS
const Duration kAnimationDuration = Duration(milliseconds: 200);
