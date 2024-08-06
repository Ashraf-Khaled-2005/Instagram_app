import 'package:flutter/material.dart';
import 'package:instagram_app/features/Story/presentation/view/widget/storybody.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class StoryPage extends StatelessWidget {
  final UserModel? user;
  const StoryPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryBody(
        usermodel: user!,
      ),
    );
  }
}
