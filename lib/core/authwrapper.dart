import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/features/authication/presentation/view/signup/SignupPage.dart';

import 'Bottombar.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else if (snapshot.hasData && snapshot.data != null) {
            return Bottombar();
          } else {
            return SignUpPage();
          }
        });
  }
}
