import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/musics/controllers/favourites_controller.dart';
import 'package:mv_player/app/modules/settings/widgets/reset_comfirmation_dialog_widget.dart';
import 'package:mv_player/app/modules/splash/views/splash_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/constants.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_item_widget.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);

  final SettingsController settingsController = Get.find();
  final FavouritesController favouritesController = Get.find();

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
      body: SingleChildScrollView(
        child: SafeArea(
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
                        onTap: () async {
                          resetComfirmationDialogWidget(
                              context: context,
                              onPressed: () async {
                                await favouritesController.resetApp();
                                Get.back();
                                restartApp();
                              },
                              resetConfirmMessage:
                                  Constants.resetConfirmMessage);
                        },
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
                        onTap: () {
                          const privacyPolicyUrl =
                              'https://doc-hosting.flycricket.io/mvplayer-privacy-policy/26967e4b-ddbf-44db-91cc-e2cfac7f4823/privacy';

                          launchUrl(Uri.parse(privacyPolicyUrl),
                              mode: LaunchMode.externalApplication);
                        },
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
      ),
    );
  }
}

void launchPrivacyPolicy() async {
  const privacyPolicyUrl =
      'https://doc-hosting.flycricket.io/mvplayer-privacy-policy/26967e4b-ddbf-44db-91cc-e2cfac7f4823/privacy';

  launchUrl(
    Uri.parse(privacyPolicyUrl),
    mode: LaunchMode.inAppWebView,
  );
}

void restartApp() {
  Get.to(SplashView());
}
