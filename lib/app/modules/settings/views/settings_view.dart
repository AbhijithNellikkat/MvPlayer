import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_item_widget.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);

  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SimpleUserCard(
              userName: "Mv player",
              textStyle: GoogleFonts.poppins(fontSize: 20),
              userProfilePic: const AssetImage(Constants.splashImage),
            ),
            Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SettingsItemWidget(
                      onTap: () {},
                      icons: CupertinoIcons.restart,
                      title: 'Reset App',
                      titleStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      titleMaxLine: 1,
                      subtitleMaxLine: 1,
                      // backgroundColor: Constants.black,
                      // iconColor: Constants.white,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => SettingsItemWidget(
                        onTap: () {},
                        icons: settingsController.isDarkMode.value
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        title: 'Switch Theme',
                        titleStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        titleMaxLine: 1,
                        subtitleMaxLine: 1,
                        trailing: Obx(
                          () => Switch.adaptive(
                            onChanged: (value) {
                              settingsController.toggleTheme();
                            },
                            value: settingsController.isDarkMode.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SettingsItemWidget(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      title: 'About',
                      titleStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      titleMaxLine: 1,
                      subtitleMaxLine: 1,
                      subtitle: "Learn more about Mv player",
                      // backgroundColor: Constants.black,
                      // iconColor: Constants.white,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SettingsItemWidget(
                      onTap: () {},
                      icons: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      titleStyle:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      titleMaxLine: 1,
                      subtitleMaxLine: 1,
                      // backgroundColor: Constants.black,
                      // iconColor: Constants.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
