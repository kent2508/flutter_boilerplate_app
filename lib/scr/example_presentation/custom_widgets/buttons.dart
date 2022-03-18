import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/constants.dart';
import 'package:vpb_flutter_boilerplate/scr/core/size/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    required this.onPress,
    this.icon,
    this.width,
    this.height,
    this.isLoading = false,
  }) : super(key: key);

  final String? text;
  final Function onPress;
  final Icon? icon;
  final double? width;
  final double? height;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading != null && isLoading! == true) {
      return Container(
        width: (width != null) ? width : SizeConfig.screenWidth,
        height: (height != null) ? height : getProportionateScreenSize(56),
        decoration: BoxDecoration(color: Theme.of(context).buttonColor, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final Widget? _child = ((text != null) && (text != ''))
        ? Text(
            text!,
            style: Theme.of(context).textTheme.button,
          )
        : (icon != null)
            ? icon
            : null;

    return Container(
      width: (width != null) ? width : SizeConfig.screenWidth,
      height: (height != null) ? height : getProportionateScreenSize(56),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).buttonColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
          ),
        ),
        onPressed: () {
          onPress();
        },
        child: _child!,
      ),
    );
  }
}
