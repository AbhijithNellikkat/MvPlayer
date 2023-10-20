import 'package:flutter/material.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage(Constants.musicsImage),
                    ),
                    title: Text(
                      '----------------------',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '------------------------------------------------------------------',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Icon(Constants.moreVert),
                  ),
                ),
              );
            },
          )),
    );
  }
}
