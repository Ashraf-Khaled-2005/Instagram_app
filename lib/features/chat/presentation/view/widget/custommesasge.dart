import 'package:flutter/material.dart';

class Customchatbabblesender extends StatelessWidget {
  final String text;
  const Customchatbabblesender({
    super.key,
    required this.formattedTime,
    required this.text,
  });

  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Custom_message_design(
              text: text,
            )),
        SizedBox(
          height: 5,
        ),
        Align(alignment: Alignment.centerLeft, child: Text(formattedTime))
      ],
    );
  }
}

class Customchatbabblerece extends StatelessWidget {
  final String text;
  const Customchatbabblerece({
    super.key,
    required this.formattedTime,
    required this.text,
  });

  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Custom_message_design(
              color: Colors.grey.withOpacity(.5),
              text: text,
            )),
        SizedBox(
          height: 5,
        ),
        Align(alignment: Alignment.centerRight, child: Text(formattedTime))
      ],
    );
  }
}

class Custom_message_design extends StatelessWidget {
  final Color? color;
  final String text;

  const Custom_message_design(
      {super.key, required this.text, this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(text),
    );
  }
}
