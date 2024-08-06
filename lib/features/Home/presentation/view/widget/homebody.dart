// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/Home/presentation/view/widget/postlistview.dart';
import 'package:instagram_app/features/Story/presentation/view/widget/storyview.dart';
import 'package:instagram_app/features/Story/presentation/view/widget/storywidget.dart';
import 'package:instagram_app/features/chat/presentation/view/chatui.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Instagram",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Chatpage(),
                      ));
                    },
                    icon: Icon(Icons.message),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('stories', isNotEqualTo: []).snapshots(),
                  builder: (context, snapshot) {
                    // Debugging: log the current user's UID
                    log('Current user UID: ${FirebaseAuth.instance.currentUser!.uid}');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Debugging: log error details
                      log('Error: ${snapshot.error}');
                      return Center(child: Text("Error loading stories"));
                    } else if (snapshot.hasData) {
                      // Debugging: log the number of documents retrieved
                      log('Number of documents: ${snapshot.data!.docs.length}');

                      if (snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No stories yet"));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final storyData = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Storyview(story: storyData),
                                  ),
                                );
                              },
                              child: StoryWidget(story: storyData),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(child: Text("No stories yet"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: 50,
        )),
        Postlistview()
      ],
    );
  }
}
