// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_app/features/addingpost/data/repos/addpostimpl.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo_impl.dart';
import 'package:instagram_app/features/authication/presentation/view/widget/Customtextfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddPostBody extends StatefulWidget {
  const AddPostBody({super.key});

  @override
  State<AddPostBody> createState() => _AddPostBodyState();
}

class _AddPostBodyState extends State<AddPostBody> {
  bool isloading = false;
  String? des;
  File? image;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

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
                    onPressed: () {},
                    icon: Icon(Icons.cancel),
                  ),
                  Text(
                    "Add Post",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      await Addpostimpl().UploadPost(context, des, image);
                      setState(() {
                        log('done');
                        isloading = false;
                      });
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
              image == null
                  ? SizedBox(
                      height: h * .3,
                    )
                  : Image.file(
                      image!,
                      height: h * .3,
                      fit: BoxFit.fill,
                    ),
              IconButton(
                  onPressed: () async {
                    image = await AuthRepoImpl().PickImageGallery();
                    setState(() {});
                  },
                  icon: Icon(Icons.upload)),
              CustomTextField(
                onChanged: (p0) {
                  des = p0;
                },
                text: "Add Comment",
                validator: (p0) {},
                maxline: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
