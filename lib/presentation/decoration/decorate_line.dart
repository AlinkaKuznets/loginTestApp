import 'package:flutter/material.dart';

class DecorateLine extends StatelessWidget {
  const DecorateLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }
}
