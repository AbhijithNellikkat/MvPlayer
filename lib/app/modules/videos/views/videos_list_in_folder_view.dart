// videos_list_in_folder_view.dart

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/video_player_view.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosListInFolderView extends StatelessWidget {
  final List<AssetEntity> videos;
  final String foldersName;

  VideosListInFolderView(
      {Key? key, required this.videos, required this.foldersName})
      : super(key: key);

  final VideosController videosController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          foldersName,
          style: GoogleFonts.poppins(
              // color: Colors.black,
              ),
        ),
        // backgroundColor: Constants.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            )),
      ),
      body: GetBuilder<VideosController>(
        builder: (controller) {
          return Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         videosController.sortAtoZ();
              //       },
              //       icon: const Icon(Icons.sort_by_alpha),
              //       tooltip: 'Sort A to Z',
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         videosController.sortZtoA();
              //       },
              //       icon: const Icon(Icons.sort_by_alpha_rounded),
              //       tooltip: 'Sort Z to A',
              //     ),
              //   ],
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          videos[index].title ?? 'Untitled',
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        leading: Stack(
                          children: [
                            FutureBuilder<Uint8List?>(
                              future: videos[index].thumbnailDataWithSize(
                                const ThumbnailSize(120, 120),
                                format: ThumbnailFormat.jpeg,
                                quality: 100,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data != null) {
                                  return Image.memory(
                                    snapshot.data!,
                                    filterQuality: FilterQuality.high,
                                    width: 120,
                                    height: 190,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Container(
                                    width: 130,
                                    height: 130,
                                    color: Colors.black,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          // color: Colors.white,
                                          ),
                                    ),
                                  );
                                }
                              },
                            ),
                            Positioned(
                              bottom: 3,
                              right: 3,
                              child: Container(
                                width: 44,
                                height: 15,
                                // color: const Color.fromARGB(255, 17, 17, 17),
                                child: Text(
                                  '${videos[index].duration.minutes}',
                                  style: const TextStyle(
                                      // color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(VideoPlayerView(
                            video: videos[index],
                          ));
                          log('Selected video path: ${videos[index].relativePath}');
                        },
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     // Replace this with your delete logic
                        //     // showDeleteConfirmationDialogWidget(context, videos[index]);
                        //     log('Selected video path for delete: ${videos[index].relativePath}');
                        //   },
                        //   icon: const Icon(
                        //     Icons.delete_forever,
                        //     color: Colors.red,
                        //   ),
                        // ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
