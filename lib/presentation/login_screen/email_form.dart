import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  const EmailForm({
    required this.formKey,
    required this.controller,
    super.key,
  });

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter email';
    }

    final emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter valid email!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        validator: (value) => emailValidator(value),
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
