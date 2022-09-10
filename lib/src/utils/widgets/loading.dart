import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: AppColors.black.withOpacity(0.6),
        ),
        Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          // width: 60.w,
          // height: 60.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryDarkColor,
                strokeWidth: 2,
              ),
              SizedBox(height: 20),
              Text(
                'Cargando...',
                style: TextStyle(fontSize: 10.sp, color: AppColors.black),
              )
            ],
          ),
        )
      ],
    );
  }
}
