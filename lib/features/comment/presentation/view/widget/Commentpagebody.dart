import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/addingpost/data/repos/addpostimpl.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/presentation/view/widget/Customtextfield.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class CommentPageBody extends StatefulWidget {
  final Map<String, dynamic> post;

  const CommentPageBody({super.key, required this.post});

  @override
  State<CommentPageBody> createState() => _CommentPageBodyState();
}

class _CommentPageBodyState extends State<CommentPageBody> {
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  String? comment;
  @override
  Widget build(BuildContext context) {
    final UserModel user = BlocProvider.of<FetchUSerDetailCubit>(context).user;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Posts')
                      .doc(widget.post['postid'])
                      .collection('Comments')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> comments =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return ListTile(
                            trailing: IconButton(
                                onPressed: () {}, icon: Icon(Icons.favorite)),
                            title: Text("${comments['username']}"),
                            subtitle: Text("${comments['comment']}"),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage('${comments['userimage']}'),
                            ),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        '${BlocProvider.of<FetchUSerDetailCubit>(context).user.image}')),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                    child: CustomTextField(
                  controller: textEditingController,
                  text: 'Add Comment',
                  validator: (p0) {
                    if (p0!.isEmpty) return "Field is requried";
                  },
                  onSaved: (p0) {
                    comment = p0;
                  },
                )),
                IconButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        Addpostimpl().addcomment(
                            post: widget.post, comment: comment!, user: user);
                        textEditingController.clear();
                        log("message");
                      }
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
