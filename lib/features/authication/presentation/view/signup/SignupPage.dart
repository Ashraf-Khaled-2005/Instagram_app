import 'package:flutter/material.dart';

import 'widget/signupbody.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: SignUpBody(),
    ));
  }
}
