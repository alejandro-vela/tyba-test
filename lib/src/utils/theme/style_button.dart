import 'package:flutter/material.dart';

import 'colors.dart';

class StyleButtom {
  ButtonStyle style(Color color, double border) => ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(border),
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all<Color>(
          AppColors.black.withOpacity(0.8),
        ),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.white.withOpacity(0.4)),
      );
}
