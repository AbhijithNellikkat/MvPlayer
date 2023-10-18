import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.count(
        crossAxisCount: 3,
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 221, 221, 221),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder,
                  size: 60,
                ),
                Text(
                  '202118',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text('197 media files',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
