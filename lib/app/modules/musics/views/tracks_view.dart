import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TracksView extends GetView {
  const TracksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.black,
            ),
            title: Text('Starboy'),
            subtitle: Text('Starboy Studio album by The Weeknd'),
            trailing: Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
