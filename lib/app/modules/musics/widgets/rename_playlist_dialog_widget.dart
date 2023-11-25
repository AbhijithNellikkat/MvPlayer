import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> renamePlaylistDialogWidget({required BuildContext context  ,  required String oldName}) async {
  TextEditingController newNameController = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Rename Playlist"),
        content: TextField(
          controller: newNameController,
          decoration: const InputDecoration(hintText: "Enter new name"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newNameController.text.trim());
            },
            child: const Text("Rename"),
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