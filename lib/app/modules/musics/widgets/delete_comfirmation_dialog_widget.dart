import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/constants.dart';

Future<void> deleteComfirmationDialogWidget({
  required BuildContext context,
  required void Function() onPressed,
  required String deleteConfirmMessage,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Delete Playlist",
          style: GoogleFonts.poppins(color: Constants.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Constants.deleteAnimation),
            Text(
              deleteConfirmMessage,
              style: GoogleFonts.poppins(color: Constants.white),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(color: Constants.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(color: Constants.white),
            ),
          ),
        ],
      );
    },
  );
}
