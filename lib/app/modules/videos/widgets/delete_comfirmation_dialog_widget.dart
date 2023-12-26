import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:photo_manager/photo_manager.dart';

Future<void> showDeleteConfirmationDialogWidget(
    BuildContext context, AssetEntity video) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Delete Video',
          style: GoogleFonts.poppins(color: Constants.white),
        ),
        content: Text(
          'Are you sure you want to delete this video ?',
          style: GoogleFonts.poppins(color: Constants.white),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Constants.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                final file = File(video.relativePath.toString());
                log('File path: ${file.path}');

                if (await file.exists()) {
                  await file.delete();
                  Get.back();
                } else {
                  log('File does not exist at path: ${file.path}');
                }
              } catch (e) {
                log('Error deleting file: $e');
              }
            },
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(color: Constants.white),
            ),
          ),
        ],
      );
    },
  );
}
