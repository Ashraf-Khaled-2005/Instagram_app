import 'package:flutter/material.dart';

import 'widget/Commentpagebody.dart';

class CommentPage extends StatelessWidget {
  final Map<String, dynamic> post;
  const CommentPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Comment",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: CommentPageBody(
        post: post,
      ),
    ));
  }
}
