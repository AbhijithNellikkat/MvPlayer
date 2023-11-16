import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/modules/splash/bindings/splash_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/home/controllers/permission_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permission = Get.put(PermissionController());
  permission.requestStoragePermission();
  permission.justAudioBackgroundInit();

  await SharedPreferences.getInstance();
  runApp(
    GetMaterialApp(
      title: "Mv Player",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
    ),
  );
}

// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';





// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Title',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }




// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: isFirstLaunch(),
//       builder: (context, snapshot) {    
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // You can replace this with your own loading indicator
//         } else {
//           return snapshot.data == true ? OnboardingScreen() : MainScreen();
//         }
//       },
//     );
//   }

//   Future<bool> isFirstLaunch() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//     if (isFirstLaunch) {
//       prefs.setBool('isFirstLaunch', false);
//     }

//     return isFirstLaunch;
//   }
// }


// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome to Your App!',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'This is your main screen.',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OnboardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Onboarding Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome to Your App!',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'This is your onboarding screen.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to the main screen
//                 Navigator.pushReplacementNamed(context, '/main');
//               },
//               child: Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ============================================================================================================================

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video List Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: VideoListScreen(),
//     );
//   }
// }

// class VideoListScreen extends StatefulWidget {
//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoListScreen> {
//   late VideoPlayerController _controller;
//   List<VideoInfo> videos = [];

//   @override
//   void initState() {
//     super.initState();
//     // ignore: deprecated_member_use
//     _controller = VideoPlayerController.network(''); // Empty URL
//     fetchVideos();
//   }

//   Future<void> fetchVideos() async {
//     final videoDir = Directory(
//         '/storage/emulated/0/DCIM/Camera'); // Replace with your video directory
//     // final videoDir = await getExternalStorageDirectory();
//     final videos = videoDir.listSync();

//     for (final video in videos) {
//       if (video is File && video.path.endsWith('.mp4')) {
//         final thumbnail = await VideoThumbnail.thumbnailFile(
//           video: video.path,
//           thumbnailPath: (await getTemporaryDirectory()).path,
//           imageFormat: ImageFormat.JPEG,
//           maxHeight: 64,
//           quality: 100,
//         );

//         setState(() {
//           this.videos.add(VideoInfo(video.path, thumbnail!));
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video List'),
//       ),
//       body: videos.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: videos.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Image.file(
//                     File(videos[index].thumbnail),
//                     width: 64,
//                     height: 64,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(videos[index].path.split('/').last),
//                   onTap: () {
//                     _controller =
//                         VideoPlayerController.file(File(videos[index].path))
//                           ..initialize().then((_) {
//                             setState(() {});
//                             _controller.play();
//                           });
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         content: AspectRatio(
//                           aspectRatio: _controller.value.aspectRatio,
//                           child: VideoPlayer(_controller),
//                         ),
//                         actions: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Close'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class VideoInfo {
//   final String path;
//   final String thumbnail;

//   VideoInfo(this.path, this.thumbnail);
// }

