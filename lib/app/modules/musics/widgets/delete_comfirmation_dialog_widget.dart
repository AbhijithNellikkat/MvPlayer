import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';

import '../../../utils/constants/constants.dart';

final SettingsController settingsController = Get.find();

Future<void> deleteComfirmationDialogWidget({
  required BuildContext context,
  required void Function() onPressed,
  required String deleteConfirmMessage,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: settingsController.isDarkMode.value
            ? Constants.white
            : Constants.black,
        title: Text(
          "Delete Playlist",
          style: GoogleFonts.poppins(
            color: settingsController.isDarkMode.value
                ? Constants.black
                : Constants.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Constants.deleteAnimation),
            Text(
              deleteConfirmMessage,
              style: GoogleFonts.poppins(
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
