import 'package:flutter/material.dart';
import 'package:mv_player/app/modules/videos/views/grid_view.dart';
import 'package:mv_player/app/modules/videos/views/list_view.dart';

// ignore: must_be_immutable
// class VideosView extends StatefulWidget {
//   VideosView({Key? key}) : super(key: key);

//   bool gridView = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: const Text(
//             'Folders',
//             style: TextStyle(color: Colors.black),
//           ),
//           actions: [IconButton(onPressed: (){}, icon: gridView ? Icon(Icons.grid_view_rounded ) : Icon(Icons.list_sharp))],
//         ),
//         body: gridView ? GridViewWidget() : ListViewWidget());
//   }
// }
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
                  ? Icon(
                      Icons.grid_view_rounded,
                      color: Colors.black,
                    )
                  : Icon(Icons.list_sharp, color: Colors.black))
        ],
      ),
      body: gridView ? GridViewWidget() : ListViewWidget(),
    );
  }
}
