import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final bool isLoading;
  final void Function() onTap;
  final String title;

  const LoginButton({
    required this.isLoading,
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color(0xFFF2796B),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(43, 43),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: widget.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
    );
  }
}
