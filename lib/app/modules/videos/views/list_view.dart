import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final VideosController videosController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: videosController.folders.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.folder,
                color: Colors.black,
                size: 40,
              ),
              title: Text(
                videosController.folders[index].name,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                // ignore: deprecated_member_use
                '${videosController.folders[index].assetCount} media files',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                videosController
                    .navigateToVideosInFolder(videosController.folders[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
