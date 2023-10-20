import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.splashImage,
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
