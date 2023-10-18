import 'package:flutter/material.dart';
import 'package:mv_player/app/modules/videos/views/grid_view.dart';
import 'package:mv_player/app/modules/videos/views/list_view.dart';

class VideosView extends StatefulWidget {
  const VideosView({super.key});

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  bool gridView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              setState(() {
                gridView = !gridView;
              });
            },
            icon: gridView
                ? const Icon(Icons.list_sharp, color: Colors.black)
                : const Icon(Icons.grid_view_outlined, color: Colors.black),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: gridView ? const GridViewWidget() : const ListViewWidget(),
    );
  }
}