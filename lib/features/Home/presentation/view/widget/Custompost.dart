import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/addingpost/data/repos/addpostimpl.dart';
import 'package:instagram_app/features/comment/presentation/view/Commentpage.dart';

import 'Cutomusername.dart';

class Custompost extends StatelessWidget {
  final Map<String, dynamic> post;
  const Custompost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomUsernameImageandname(
          w: w,
          name: post['username'],
          image: post['userimage'],
          onPressed: () async {
            if (post['uid'] == FirebaseAuth.instance.currentUser!.uid)
              await Addpostimpl().deletepost(post: post);
            else {
              log("message");
            }
          },
        ),
        SizedBox(
          height: 7,
        ),
        Image.network(
          post['imagepost'],
          width: w,
          height: h * .5,
          fit: BoxFit.fill,
        ),
        Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Addpostimpl().addlikepost(postmap: post);
                },
                icon: Icon(
                  Icons.favorite,
                  color: post['likes']
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Colors.red
                      : Colors.white,
                )),
            IconButton(onPressed: () {}, icon: Icon(Icons.comment))
          ],
        ),
        Text(
          '${post['likes'].length} likes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          post['des'] != null ? post['des'] : "",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CommentPage(
                  post: post,
                ),
              ));
            },
            child: Text(
              "Add Comment",
              style: TextStyle(color: Colors.lightBlue),
            )),
        const Text(
          '1 hour age',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
