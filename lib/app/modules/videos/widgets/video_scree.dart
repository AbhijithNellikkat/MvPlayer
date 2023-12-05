import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    getAllVideos();
  }

  Future<void> getAllVideos() async {
    FetchAllVideos fetchVideos = FetchAllVideos();
    List<dynamic> fetchedVideos = await fetchVideos.getAllVideos();
    setState(() {
      videos = fetchedVideos.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Videos',
            style: GoogleFonts.poppins(),
          ),
        ),
        body: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(
                  'Video ${index + 1}: ${videos[index]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                    'Description or additional info about the video'),
                leading: const Icon(Icons
                    .play_arrow), // You can use a play icon or a thumbnail here
                onTap: () {
                  // Handle the tap event, e.g., navigate to a detailed view
                },
              ),
            );
          },
        ));
  }
}
