import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;

  final int maxline;
  final String? Function(String?)? validator;
  final Widget? icon;
  final String text;
  const CustomTextField(
      {super.key,
      required this.text,
      this.icon,
      required this.validator,
      this.maxline = 1,
      this.onSaved,
      this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxline,
      validator: validator,
      decoration: InputDecoration(
          suffixIcon: icon,
          label: Text(text),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
