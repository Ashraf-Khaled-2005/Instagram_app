import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';
import 'package:instagram_app/features/chat/presentation/view/chatdetail.dart';

import 'widget/listtile.dart';

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  Text(
                    "Chats",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Users').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<UserModel> users = [];
                  for (var element in snapshot.data!.docs) {
                    UserModel userModel = UserModel.fromdocu(element);
                    if (userModel.uid !=
                        FirebaseAuth.instance.currentUser!.uid) {
                      users.add(userModel);
                    }
                  }
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chatdetail(
                                          userModel: users[index],
                                        )),
                              );
                            },
                            child: Listtilechat(userModel: users[index]),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
