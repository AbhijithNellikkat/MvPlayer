import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ListViewWidget extends StatefulWidget {
  ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  // final VideosController videosController = Get.put(VideosController());

  List<AssetEntity> videos = [];

  List<AssetPathEntity> folders = [];

  @override
  void initState() {
    super.initState();
    // videosController.fetchMediaPaths();
    // fetchMediaPaths();
    fetchMediaFolders();
  }

  Future<void> fetchMediaFolders() async {
    try {
      final List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.video);

      setState(() {
        folders = paths;
      });
    } catch (e) {
      print('Error fetching media folders: $e');
    }
  }

  // Future<void> fetchMediaPaths() async {
  //   try {
  //     final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();

  //     for (var path in paths) {
  //       final List<AssetEntity> pathVideos =
  //           await path.getAssetListRange(start: 0, end: path.assetCount);
  //       videos.addAll(pathVideos);
  //     }

  //     setState(
  //         () {}); // Trigger a rebuild of the UI to display the fetched videos
  //   } catch (e) {
  //     log('Error fetching media paths: $e');
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(0.8),
  //     child: ListView.builder(
  //       itemCount: 30,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () {
  //             videosController.fetchMediaPaths();
  //           },
  //           child: const ListTile(
  //             leading: Icon(
  //               Icons.folder,
  //               size: 50,
  //               color: Colors.black,
  //             ),
  //             title: Text(
  //               '202118',
  //               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //             ),
  //             subtitle: Text(
  //               '197 media files',
  //               style: TextStyle(fontSize: 11),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(folders[index].name ?? 'Untitled Folder'),
            subtitle: Text('Number of Videos: ${folders[index].assetCount}'),
            onTap: () {
              navigateToVideosInFolder(folders[index]);
            },
          );
        },
      ),
    );
  }

  Future<void> navigateToVideosInFolder(AssetPathEntity folder) async {
    // ignore: deprecated_member_use
    final List<AssetEntity> videos =
        await folder.getAssetListRange(start: 0, end: folder.assetCount);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoListInFolderScreen(videos: videos),
      ),
    );
  }
}

class VideoListInFolderScreen extends StatelessWidget {
  final List<AssetEntity> videos;

  VideoListInFolderScreen({required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos in Folder'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videos[index].title ?? 'Untitled'),
            subtitle: Text('Path: ${videos[index].relativePath}'),
            onTap: () {
              // Handle video selection, e.g., navigate to a video player screen
              // with the selected video.
              print('Selected video path: ${videos[index].relativePath}');
            },
          );
        },
      ),
    );
  }
}
