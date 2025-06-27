import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFFF2796B),
        fontSize: 23,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    );
  }
}
