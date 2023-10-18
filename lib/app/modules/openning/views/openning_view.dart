import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/app/utils/constants/images.dart';
import 'package:mv_player/widgets/custom_button_widget.dart';

import '../controllers/openning_controller.dart';

class OpenningView extends GetView<OpenningController> {
  const OpenningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 340,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ConstantsImages.openningBgImage),
                ),
              ),
            ),
            const Text(
              'Explore the App',
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
            ),
            const Text(
              Constants.musicOnbordingDescription,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtonWidget(
                    borderWidth: 0,
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    text: 'Sign In',
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  CustomButtonWidget(
                    borderWidth: 1,
                    onTap: () {
                      Get.toNamed(Routes.CREATE_ACCOUNT);
                    },
                    text: 'Create Account',
                    bgColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
