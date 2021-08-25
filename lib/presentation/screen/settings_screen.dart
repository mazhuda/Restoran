import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/external/navigation.dart';
import 'package:restoran/external/restoran_shared_pref.dart';
import 'package:restoran/presentation/bloc/scheduling_bloc/scheduling_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => SchedulingBloc(
        restoranSharePreferences: RestoranSharePreferencesImpl(),
      )..add(CheckScheduling()),
      child: Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Halaman Setting",
            style: TextStyle(
                color: CustomColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 16.w),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.5),
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: ListTile(
                title: Text("Tampilkan Notifikasi"),
                trailing: BlocBuilder<SchedulingBloc, SchedulingState>(
                  builder: (context, state) {
                    if (state is SchedulingSetAlarmState) {
                      return Switch.adaptive(
                          value: true,
                          onChanged: (_) {
                            if (Platform.isIOS) {
                              alertDialog(context);
                            } else {
                              BlocProvider.of<SchedulingBloc>(context)
                                  .add(CancelScheduling());
                            }
                          });
                    } else {
                      return Switch.adaptive(
                          value: false,
                          onChanged: (_) {
                            if (Platform.isIOS) {
                              alertDialog(context);
                            } else {
                              BlocProvider.of<SchedulingBloc>(context)
                                  .add(SetScheduling());
                            }
                          });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  alertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Segera Hadir!'),
          content: Text('Fitur ini akan segera hadir'),
          actions: [
            CupertinoDialogAction(
              child: Text('Tutup'),
              onPressed: () {
                CustomNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
