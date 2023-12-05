import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    splashController.delayAndNavigate();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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


// SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 Constants.splashImage,
//                 width: 200,
//               )
//             ],
//           ),
//         ),
//       ),


