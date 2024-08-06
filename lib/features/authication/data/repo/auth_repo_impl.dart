import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends Auth_Repo {
  @override
  Future<File?> PickImageGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  @override
  Future<void> SignUp(
      {required String Email,
      pass,
      username,
      required List followers,
      following,
      required String image,
      required List stories}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: pass,
      );
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'password': pass,
        'email': Email,
        'username': username,
        'imageurl': image,
        'followers': followers,
        'following': following,
        'stories': stories
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> Getimgaeurl(String uuid, File image, String child) async {
    final rref =
        FirebaseStorage.instance.ref().child(child).child(uuid + 'jpg');
    await rref.putFile(image!);
    final imageurl = await rref.getDownloadURL();
    return imageurl;
  }

  @override
  Future<File?> PickVidopGallery() async {
    var video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video != null) {
      return File(video.path);
    } else {
      return null;
    }
  }

  @override
  follow_user({required String uuid}) async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserId)
          .get();

      // Ensure 'following' field exists and is a list
      List following =
          (userSnapshot.data() as Map<String, dynamic>)['following'] ?? [];

      if (!following.contains(uuid)) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUserId)
            .update({
          'following': FieldValue.arrayUnion([uuid])
        });

        await FirebaseFirestore.instance.collection('Users').doc(uuid).update({
          'follower': FieldValue.arrayUnion([currentUserId])
        });
      }
    } catch (e) {
      print('Error following user: $e');
    }
  }
}
