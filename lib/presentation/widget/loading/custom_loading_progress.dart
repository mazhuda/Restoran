import 'package:flutter/material.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.only(top: 16.w, left: 32.w, right: 32.w),
          child: Text(
            "Tunggu sebentar, masih proses ambil data...",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.green,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
