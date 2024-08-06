// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo_impl.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class StoryBody extends StatefulWidget {
  final UserModel usermodel;
  const StoryBody({super.key, required this.usermodel});

  @override
  State<StoryBody> createState() => _StoryBodyState();
}

class _StoryBodyState extends State<StoryBody> {
  VideoPlayerController? videocontroller;
  bool isloading = false;
  String? des;
  File? video;
  File? image;

  @override
  void dispose() {
    videocontroller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                  ),
                  Text(
                    "Add Story",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (image != null || video != null) {
                        setState(() {
                          isloading = true;
                        });
                        var media = video != null ? video : image;
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        final uuid = Uuid().v4();
                        final rref = FirebaseStorage.instance
                            .ref()
                            .child('UsersStories')
                            .child(uuid + 'jpg');
                        await rref.putFile(media!);
                        var content = await rref.getDownloadURL();

                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(uid)
                            .update({
                          'stories': FieldValue.arrayUnion([
                            {
                              'uid': uid,
                              'storyid': uuid,
                              'content': content,
                              'type': video != null ? 'video' : 'image',
                              'data': Timestamp.now(),
                              'views': [],
                              'username': widget.usermodel.username,
                              'userimage': widget.usermodel.image
                            }
                          ])
                        });
                        log('done');
                        setState(() {
                          isloading = false;
                          video = null;
                          image = null;
                        });
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                  ),
                ],
              ),
              image != null
                  ? Image.file(
                      image!,
                      height: h * .3,
                      fit: BoxFit.fill,
                    )
                  : video != null
                      ? SizedBox(
                          height: h * .3,
                          width: w,
                          child: VideoPlayer(videocontroller!),
                        )
                      : SizedBox(
                          height: h * .3,
                        ),
              PopupMenuButton(
                icon: Icon(Icons.upload),
                onSelected: (value) async {
                  if (value == 'Image') {
                    if (videocontroller != null) {
                      await videocontroller!.pause();
                    }
                    image = await AuthRepoImpl().PickImageGallery();
                    video = null;
                    setState(() {});
                  }
                  if (value == 'Video') {
                    video = await AuthRepoImpl().PickVidopGallery();
                    if (video != null) {
                      videocontroller = VideoPlayerController.file(video!);
                      await videocontroller!.initialize();
                      await videocontroller!.play();
                      setState(() {
                        image = null;
                      });
                    }
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("Image"),
                      value: 'Image',
                    ),
                    PopupMenuItem(
                      child: Text("Video"),
                      value: "Video",
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
