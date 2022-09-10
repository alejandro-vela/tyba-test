import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors.dart';
import '../theme/style_button.dart';

class ButtonExtended extends StatelessWidget {
  final String description;
  final Color? color;
  final double? shape;
  final VoidCallback? onPressed;
  const ButtonExtended(
      {Key? key,
      required this.description,
      required this.onPressed,
      this.color,
      this.shape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:
          StyleButtom().style(color ?? AppColors.primaryLigthColor, shape ?? 0),
      onPressed: onPressed,
      child: Center(
        child: Text(
          description,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
