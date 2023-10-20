import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/routes/app_pages.dart';

import '../../../utils/constants/constants.dart';


class TracksView extends GetView {
  const TracksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.MUSICPLAYER);
            },
            child: const ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage(Constants.musicsImage),
              ),
              title: Text(
                'Starboy',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                'Starboy Studio album by The Weeknd',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Icon(Constants.moreVert),
            ),
          ),
        );
      },
    );
  }
}
