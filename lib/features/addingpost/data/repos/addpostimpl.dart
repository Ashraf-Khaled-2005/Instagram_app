import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/addingpost/data/repos/addpostrepo.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo_impl.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';
import 'package:uuid/uuid.dart';

import '../../../authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';

class Addpostimpl extends Addpostrepo {
  @override
  Future<void> UploadPost(
      BuildContext context, String? des, File? image) async {
    try {
      UserModel user = BlocProvider.of<FetchUSerDetailCubit>(context).user;
      final uuid = Uuid().v4();
      String imageurl =
          await AuthRepoImpl().Getimgaeurl(uuid, image!, 'Postsimages');

      FirebaseFirestore.instance.collection('Posts').doc(uuid).set({
        'username': user.username,
        'uid': user.uid,
        'userimage': user.image,
        'imagepost': imageurl,
        'postid': uuid,
        'des': des,
        'likes': []
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addlikepost({required Map<String, dynamic> postmap}) async {
    if (postmap['likes'].contains(FirebaseAuth.instance.currentUser!.uid)) {
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postmap['postid'])
          .update(
        {
          'likes':
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        },
      );
    } else {
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postmap['postid'])
          .update(
        {
          'likes':
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        },
      );
    }
  }

  @override
  Future<void> deletepost({required Map<String, dynamic> post}) async {
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post['postid'])
        .delete();
  }

  @override
  Future<void> addcomment(
      {required Map<String, dynamic> post,
      required String comment,
      required UserModel user}) async {
    final uuid = Uuid().v4();

    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(post['postid'])
        .collection('Comments')
        .doc(uuid)
        .set({
      'comment': comment,
      'uid': user.uid,
      'postid': post['postid'],
      'commentid': uuid,
      'userimage': user.image,
      'username': user.username
    });
  }
}
