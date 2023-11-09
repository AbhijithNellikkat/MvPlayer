import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/recently_played_controller.dart';

class RecentlyPlayedView extends GetView<RecentlyPlayedController> {
  
  const RecentlyPlayedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.refresh_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        'Recently Played',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '10 songs',
        style: GoogleFonts.poppins(fontSize: 12),
      ),
    );
  }
}
