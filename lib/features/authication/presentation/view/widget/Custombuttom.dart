import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomBottom({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: WidgetStatePropertyAll(Colors.blue),
        ),
      ),
    );
  }
}
