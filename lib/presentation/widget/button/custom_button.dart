import 'package:flutter/material.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double borderRadius;

  CustomButton({
    @required this.text,
    @required this.onTap,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.w,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.sp,
                color: CustomColors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
