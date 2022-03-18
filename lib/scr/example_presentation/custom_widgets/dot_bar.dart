import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/constants.dart';

class PagingDot extends StatelessWidget {
  const PagingDot({
    Key? key,
    required this.currentIndex,
    required this.dotNumber,
  }) : super(key: key);
  final int currentIndex;
  final int dotNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotNumber,
        (index) => AnimatedContainer(
          duration: kAnimationDuration,
          margin: const EdgeInsets.only(right: 5),
          height: 6,
          width: currentIndex == index ? 20 : 6,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}
