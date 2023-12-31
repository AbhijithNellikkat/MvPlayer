import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';

class SettingsItemWidget extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  final IconData icons;

  final String title;
  final Color iconColor;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  final int? subtitleMaxLine;

  SettingsItemWidget(
      {super.key,
      required this.icons,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.trailing,
      this.onTap,
      this.backgroundColor,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.iconColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.all(5),
          child: Obx(
            () => Icon(
              icons,
              size: SettingsScreenUtils.settingsGroupIconSize,
              color: settingsController.isDarkMode.value
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        title: Text(
          title,
          style: titleStyle ??
              GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                // color: Constants.white,
              ),
          maxLines: titleMaxLine,
        ),
        subtitle: (subtitle != null)
            ? Text(
                subtitle!,
                style: subtitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
                maxLines: subtitleMaxLine,
                overflow:
                    subtitleMaxLine != null ? TextOverflow.ellipsis : null,
              )
            : null,
        trailing:
            (trailing != null) ? trailing : const Icon(Icons.navigate_next),
      ),
    );
  }
}
