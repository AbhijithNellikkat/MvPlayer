import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderInsideView extends GetView {
  const FolderInsideView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.amber,
      child: const Center(
        child: Text('Folder Inside View '),
      ),
    );
  }
}
