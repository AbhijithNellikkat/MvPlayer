import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicPlayerView extends GetView {
  const MusicPlayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: const Center(
          child: Text(
            'MusicPlayerView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
