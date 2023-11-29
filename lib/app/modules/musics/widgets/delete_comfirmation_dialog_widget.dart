import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text("Delete Playlist"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Constants.deleteAnimation),
            Text(deleteConfirmMessage),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text("Delete"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
