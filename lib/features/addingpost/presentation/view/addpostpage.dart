import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/addpostbody.dart';

class Addpostpage extends StatelessWidget {
  const Addpostpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: AddPostBody(),
    ));
  }
}
