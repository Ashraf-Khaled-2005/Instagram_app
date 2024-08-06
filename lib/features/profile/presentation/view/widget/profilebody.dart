import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/Story/presentation/view/SortyAdding.dart';
import 'package:instagram_app/features/authication/presentation/view/widget/Custombuttom.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class ProfileBody extends StatelessWidget {
  final UserModel model;
  const ProfileBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(model.image)),
                      Positioned(
                          right: -10,
                          bottom: -0,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StoryPage(
                                    user: model,
                                  ),
                                ));
                              },
                              icon: const Icon(Icons.add)))
                    ],
                  ),
                  Text(
                    "${model.username}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('Posts')
                        .where('username', isEqualTo: model.username)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Text(
                          "${snapshot.data!.docs.length}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return const Text(
                          "0",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                  const Text(
                    "Posts",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "${model.Followers.length}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Followers",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "${model.Following.length}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Following",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: w,
            child: const CustomBottom(text: "Edit Profile"),
          ),
          const Divider(
            thickness: 3,
          ),
          Builder(builder: (context) {
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Posts')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1),
                        itemBuilder: (context, index) {
                          return Image.network(
                            "${snapshot.data!.docs[index]['imagepost']}",
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          })
        ],
      ),
    );
  }
}
