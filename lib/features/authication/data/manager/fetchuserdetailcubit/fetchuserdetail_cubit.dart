import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetailstate.dart';

class FetchUSerDetailCubit extends Cubit<FetchUserDetailstate> {
  FetchUSerDetailCubit() : super(FetchUserDetailintail());
  late UserModel user;

  Future<UserModel?> getdetail({required String uid}) async {
    emit(FetchUserDetailloading());
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      user = UserModel.fromdocu(snapshot);
      emit(FetchUserDetailsuccess(userModel: user));
      return user;
    } catch (e) {
      emit(FetchUserDetailfail(err: e.toString()));
      return null;
    }
  }
}
