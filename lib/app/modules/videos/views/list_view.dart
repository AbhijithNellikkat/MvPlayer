import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.folder,
                size: 50,
                color: Colors.black,
              ),
              title: Text('202118'),
              subtitle: Text('197 media files'),
              trailing: Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}
