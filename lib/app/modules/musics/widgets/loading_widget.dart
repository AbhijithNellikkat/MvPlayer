import 'package:flutter/material.dart';
import 'package:mv_player/app/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: const CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.black,
                        // backgroundImage: AssetImage(Constants.musicsImage),
                      ),
                      title: Container(
                        height: 21,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      subtitle: Container(
                        width: 10,
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      trailing: Icon(Constants.moreVert),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
