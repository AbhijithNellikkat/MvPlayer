import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mv_player/app/data/db_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedViews extends GetView {
  RecentlyPlayedViews({Key? key}) : super(key: key);

  final DbFunctions dbFunctions = DbFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Played'),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: dbFunctions.getRecentlyPlayed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final recentlyPlayed = snapshot.data ?? [];

          return GridView.builder(
            itemCount: recentlyPlayed.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final song = recentlyPlayed[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      song.title,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
