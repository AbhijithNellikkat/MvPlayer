import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/routes/app_pages.dart';
import '../../../utils/constants/constants.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.UPDATEPROFILE);
              },
              child: Text(
                'Edit',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              backgroundColor: Constants.black,
              maxRadius: 65,
              child: Icon(Constants.user, size: 60),
            ),
            const SizedBox(height: 20),
            Text(
              'Abhijith Nellikkat',
              style: GoogleFonts.poppins(fontSize: 19),
            ),
            const SizedBox(height: 2),
            Text(
              'abhijithnellikkat@gmail.com',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                      color: Colors.red, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      )),
    );
  }
}
