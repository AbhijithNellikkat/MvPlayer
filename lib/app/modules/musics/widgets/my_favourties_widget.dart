import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFavouritesWidget extends StatelessWidget {
  const MyFavouritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
