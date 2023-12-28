import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    splashController.delayAndNavigate();

    return Scaffold(
      backgroundColor: Constants.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/sample_logo-removebg-preview.png',
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
