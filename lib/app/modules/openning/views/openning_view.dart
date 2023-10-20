import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:mv_player/widgets/custom_button_widget.dart';

import '../../../utils/styles/text_styles.dart';
import '../controllers/openning_controller.dart';

class OpenningView extends GetView<OpenningController> {
  const OpenningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldBgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 370,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Constants.openningBgImage),
                ),
              ),
            ),
            Text(Constants.openningScreenHeading, style: openningScreenHeading),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(Constants.musicOnbordingDescription,
                  style: openningScreenDescription),
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
                    bgColor: Constants.black,
                    textColor: Constants.white,
                  ),
                  CustomButtonWidget(
                    borderWidth: 1,
                    onTap: () {
                      Get.toNamed(Routes.CREATE_ACCOUNT);
                    },
                    text: 'Create Account',
                    bgColor: Constants.white,
                    textColor: Constants.black,
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
