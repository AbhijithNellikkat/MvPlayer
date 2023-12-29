import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';

import '../../../utils/constants/constants.dart';
// import 'package:mv_player/app/utils/constants/constants.dart';

final SettingsController settingsController = Get.find();

Future<String?> renamePlaylistDialogWidget(
    {required BuildContext context, required String oldName}) async {
  TextEditingController newNameController = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: settingsController.isDarkMode.value
            ? Constants.white
            : Constants.black,
        title: Text(
          "Rename Playlist",
          style: GoogleFonts.poppins(
            color: settingsController.isDarkMode.value
                ? Constants.black
                : Constants.white,
          ),
        ),
        content: TextField(
          controller: newNameController,
          style: GoogleFonts.poppins(
            color: settingsController.isDarkMode.value
                ? Constants.black
                : Constants.white,
          ),
          decoration: InputDecoration(
              hintText: "Enter new name",
              hintStyle: GoogleFonts.poppins(
                color: settingsController.isDarkMode.value
                    ? Constants.black
                    : Constants.white,
              )),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newNameController.text.trim());
            },
            child: Text(
              "Rename",
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
