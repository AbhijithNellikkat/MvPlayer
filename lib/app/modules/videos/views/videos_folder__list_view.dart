import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/settings/controllers/settings_controller.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/utils/constants/constants.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final VideosController videosController = Get.find();

  final SettingsController settingsController = Get.find();

  @override
  void initState() {
    videosController.fetchMediaFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: videosController.folders.length,
          itemBuilder: (context, index) {
            final foldersName = videosController.folders[index].name;
            return ListTile(
              leading: Icon(
                Icons.folder,
                size: 40,
                color: settingsController.isDarkMode.value
                    ? Constants.white
                    : Constants.black,
              ),
              title: Text(
                videosController.folders[index].name,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              subtitle: FutureBuilder<int>(
                future: videosController.folders[index].assetCountAsync,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Loading...',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error loading count',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    return Text(
                      '${snapshot.data} videos',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }
                },
              ),
              onTap: () {
                videosController.navigateToVideosInFolder(
                  folder: videosController.folders[index],
                  foldersName: foldersName,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
