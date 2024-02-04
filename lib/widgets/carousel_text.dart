import 'package:flutter/material.dart';

@override
Widget carouselText(String text) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      textAlign: TextAlign.left,
    ),
  );
}
