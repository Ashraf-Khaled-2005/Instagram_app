import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class FetchUserDetailstate {}

class FetchUserDetailsuccess extends FetchUserDetailstate {
  final UserModel userModel;

  FetchUserDetailsuccess({required this.userModel});
}

class FetchUserDetailfail extends FetchUserDetailstate {
  final String err;

  FetchUserDetailfail({required this.err});
}

class FetchUserDetailloading extends FetchUserDetailstate {}

class FetchUserDetailintail extends FetchUserDetailstate {}
