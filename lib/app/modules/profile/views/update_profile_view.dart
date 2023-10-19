import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/icons.dart';

class UpdateProfileView extends GetView {
  UpdateProfileView({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    usernameController.text = 'Abhijith Nellikkat';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: ConstantColors.BLACK,
            maxRadius: 65,
            child: Icon(ConstantIcons.USER, size: 60),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {},
            child: Text(
              'edit',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              controller: usernameController,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),
                child: Text('save'),
              ))
        ],
      )),
    );
  }
}
