import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaylistsView extends GetView {
  PlaylistsView({Key? key}) : super(key: key);

  final TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'My Favourties',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                '0 songs',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.music_note_sharp,
                  color: Colors.white,
                ),
              ),
              title: const Text('Malayalam songs'),
              subtitle: Text(
                '209 songs',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                maxRadius: 30,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.music_note_sharp,
                  color: Colors.white,
                ),
              ),
              title: const Text('English songs'),
              subtitle: Text(
                '119 songs',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.playlist_add,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Create New Playlist',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: TextFormField(
                          controller: playlistController,
                          style: TextStyle(color: Colors.white),
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text('Create'),
                          ))
                    ],
                  ),
                );
              },
            );
          },
          label: const Text('New playlist')),
    );
  }
}
