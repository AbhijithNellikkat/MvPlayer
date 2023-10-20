import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.text,
    required this.onTap,
    required this.borderWidth,
  });

  final Color bgColor;
  final Color textColor;
  final String text;
  final void Function()? onTap;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320,
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: borderWidth, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
