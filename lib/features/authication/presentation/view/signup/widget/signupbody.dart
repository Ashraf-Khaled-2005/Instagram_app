import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_app/features/authication/data/repo/auth_repo_impl.dart';
import 'package:instagram_app/features/authication/presentation/view/signin/Loginpage.dart';
import 'package:uuid/uuid.dart';

import '../../widget/Custombuttom.dart';
import '../../widget/Customtextfield.dart';
import 'imagepickerwidgert.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool isloading = false;
  String? email, pass, username;
  File? image;
  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                const Text(
                  "Instagram App",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: h * .1,
                ),
                Stack(
                  children: [
                    ImagePickerWidget(
                      image: image,
                    ),
                    Positioned(
                      right: -9,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () async {
                          image = await AuthRepoImpl().PickImageGallery();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  onSaved: (p0) {
                    username = p0;
                  },
                  text: "UserName",
                  validator: (p0) {
                    if (p0!.isEmpty) return "Field is required";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  onSaved: (p0) {
                    email = p0;
                  },
                  text: "Email",
                  validator: (p0) {
                    if (p0!.isEmpty || !p0.contains('@'))
                      return "Enter vaild Email";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  onSaved: (p0) {
                    pass = p0;
                  },
                  validator: (p0) {
                    if (p0!.isEmpty || p0.length < 7)
                      return "Enter Vaild Password";
                  },
                  text: "Password",
                  icon: Icon(Icons.visibility_off),
                ),
                const SizedBox(
                  height: 30,
                ),
                isloading
                    ? CircularProgressIndicator()
                    : CustomBottom(
                        onPressed: () async {
                          if (image != null) {
                            if (key.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              final uuid = Uuid().v4();
                              String imageurl = await AuthRepoImpl()
                                  .Getimgaeurl(uuid, image!, 'Userimages');

                              key.currentState!.save();
                              await AuthRepoImpl().SignUp(
                                  Email: email!,
                                  pass: pass!,
                                  username: username,
                                  followers: [],
                                  following: [],
                                  image: imageurl,
                                  stories: []);
                              isloading = false;
                            }
                          } else {
                            log('dff');
                          }
                        },
                        text: 'SignUp',
                      ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LogInPage(),
                      ));
                    },
                    child: const Text(
                      "Already Have an Account ? ",
                      style: TextStyle(color: Colors.cyan, fontSize: 16),
                    )),
                SizedBox(
                  height: h * .1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
