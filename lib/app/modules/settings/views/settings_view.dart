import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);

  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(color: Constants.black),
        ),
        backgroundColor: Constants.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ListView(
            children: [
              SimpleUserCard(
                userName: "Mv player",
                textStyle: GoogleFonts.poppins(fontSize: 20),
                userProfilePic: const AssetImage(Constants.splashImage),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.restart,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.black,
                    ),
                    title: 'Reset App',
                    titleStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    titleMaxLine: 1,
                    subtitleMaxLine: 1,
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.light_mode_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.black,
                    ),
                    title: 'Switch Theme',
                    titleStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    subtitle: "Automatic",
                    trailing: Switch.adaptive(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.black,
                    ),
                    title: 'About',
                    titleStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    subtitle: "Learn more about Mv player",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.privacy_tip,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.black,
                    ),
                    title: 'Privacy Policy',
                    titleStyle:
                        GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
