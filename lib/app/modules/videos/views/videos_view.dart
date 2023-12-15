import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/videos/controllers/videos_controller.dart';
import 'package:mv_player/app/modules/videos/views/videos_folder__list_view.dart';
import 'package:mv_player/app/modules/videos/views/videos_folder_grid_view.dart';

// ignore: must_be_immutable
class VideosView extends StatelessWidget {
  VideosView({super.key});

  bool gridView = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideosController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Folders',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  controller.toggleView();
                },
                icon: Icon(
                  controller.isGridView.value
                      ? Icons.list_sharp
                      : Icons.grid_view_rounded,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: controller.isGridView.value
              ? const GridViewWidget()
              : const ListViewWidget(),
        );
      },
    );
  }
}
