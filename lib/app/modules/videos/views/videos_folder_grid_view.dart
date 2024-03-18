import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/videos_controller.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  final VideosController videosController = Get.find();

  @override
  void initState() {
    videosController.fetchMediaFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.all(3),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: videosController.folders.length,
        itemBuilder: (context, index) {
          final foldersName = videosController.folders[index].name;
          return Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                videosController.navigateToVideosGridInFolder(
                  folder: videosController.folders[index],
                  foldersName: foldersName,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.folder,
                    size: 80,
                  ),
                  Text(
                    videosController.folders[index].name,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  FutureBuilder<int>(
                    future: videosController.folders[index].assetCountAsync,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: GoogleFonts.poppins(
                              fontSize: 10, fontWeight: FontWeight.w400),
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
                              fontSize: 10, fontWeight: FontWeight.w400),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
