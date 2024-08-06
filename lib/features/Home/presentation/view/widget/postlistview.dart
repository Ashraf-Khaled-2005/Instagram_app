import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Custompost.dart';

class Postlistview extends StatelessWidget {
  const Postlistview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          if (snapshot.data!.docs.length != 0) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: snapshot.data!.docs.length,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Custompost(
                      post: snapshot.data!.docs[index].data()
                          as Map<String, dynamic>),
                );
              },
            ));
          } else {
            return SliverToBoxAdapter(
              child: Center(
                child: const Text('No Posts yes'),
              ),
            );
          }
        });
  }
}
