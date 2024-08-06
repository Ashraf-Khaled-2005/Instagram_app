// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/Story/presentation/view/SortyAdding.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo_impl.dart';
import 'package:instagram_app/features/authication/presentation/view/widget/Custombuttom.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class ProfilePageAnthorBody extends StatefulWidget {
  final UserModel model;
  const ProfilePageAnthorBody({super.key, required this.model});

  @override
  State<ProfilePageAnthorBody> createState() => _ProfilePageAnthorBodyState();
}

class _ProfilePageAnthorBodyState extends State<ProfilePageAnthorBody> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = BlocProvider.of<FetchUSerDetailCubit>(context).user;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.model.image),
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StoryPage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.model.username}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "5",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Posts",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "5",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Followers",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "5",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Following",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: w,
            child: CustomBottom(
              text: (userModel?.Following.contains(widget.model.uid) ?? false)
                  ? "Unfollow"
                  : "Follow",
              onPressed: () async {
                if (!(userModel?.Following.contains(widget.model.uid) ??
                    false)) {
                  await AuthRepoImpl().follow_user(uuid: widget.model.uid);
                  log("Followed user");
                  setState(() {
                    userModel?.Following.add(widget.model.uid);
                  });
                }
              },
            ),
          ),
          Divider(thickness: 3),
          Builder(builder: (context) {
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Posts')
                  .where('uid', isEqualTo: widget.model.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(
                          "${snapshot.data!.docs[index]['imagepost']}",
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  );
                } else {
                  return Text("No posts available.");
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
