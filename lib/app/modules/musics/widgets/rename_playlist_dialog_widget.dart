import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

Future<String?> renamePlaylistDialogWidget(
    {required BuildContext context, required String oldName}) async {
  TextEditingController newNameController = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Rename Playlist",
          style: GoogleFonts.poppins(color: Constants.white),
        ),
        content: TextField(
          controller: newNameController,
          style: GoogleFonts.poppins(color: Constants.white),
          decoration: InputDecoration(
              hintText: "Enter new name",
              hintStyle: GoogleFonts.poppins(color: Constants.white)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newNameController.text.trim());
            },
            child: Text(
              "Rename",
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
