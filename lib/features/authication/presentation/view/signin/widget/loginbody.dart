import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/core/Bottombar.dart';

import '../../widget/Custombuttom.dart';
import '../../widget/Customtextfield.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  bool isloading = false;
  String? email, pass;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(
                  height: h * .1,
                ),
                const Text(
                  "Instagram App",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    if (p0!.isEmpty) return "Enter vaild Email";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  onSaved: (p0) {
                    pass = p0;
                  },
                  text: "Password",
                  icon: Icon(Icons.visibility_off),
                  validator: (p0) {
                    if (p0!.isEmpty) return "Enter vaild Email";
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                isloading == false
                    ? CustomBottom(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            key.currentState!.save();
                            try {
                              isloading = true;
                              setState(() {});
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email!, password: pass!);
                              isloading = false;
                              setState(() {});
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Bottombar(),
                              ));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          }
                        },
                        text: 'Login',
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                Text("OR"),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {},
                  child: const Text(
                    "Don't Have an Account ? ",
                    style: TextStyle(color: Colors.cyan, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
