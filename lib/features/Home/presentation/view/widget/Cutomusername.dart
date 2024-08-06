import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomUsernameImageandname extends StatelessWidget {
  final void Function()? onPressed;
  final String? image, name;
  final CrossAxisAlignment crossAxisAlignment;
  const CustomUsernameImageandname(
      {super.key,
      required this.w,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.image,
      this.name,
      this.onPressed});

  final double w;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CircleAvatar(radius: 30, backgroundImage: NetworkImage(image!)),
        SizedBox(
          width: w * .05,
        ),
        Text(
          name!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Spacer(),
        IconButton(onPressed: onPressed, icon: Icon(Icons.delete))
      ],
    );
  }
}
