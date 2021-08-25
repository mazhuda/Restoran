import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restoran/domain/router/restoran_router.dart';
import 'package:restoran/external/custom_colors.dart';
import 'package:restoran/external/custom_screen_utils.dart';
import 'package:restoran/external/image_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restoran/presentation/bloc/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  final RestoranRouter _restoranRouter = RestoranRouterImpl();

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplashScreenEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            Future.delayed(Duration(seconds: 2))
                .then((_) => _restoranRouter.goToHome());
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: CustomColors.white,
            body: Center(
              child: Image.asset(
                ImageStrings.logo,
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}
