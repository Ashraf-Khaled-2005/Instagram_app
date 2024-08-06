import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetailstate.dart';

import 'widget/profileanthoruserbody.dart';

class ProfilePageanthor extends StatelessWidget {
  const ProfilePageanthor({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FetchUSerDetailCubit, FetchUserDetailstate>(
        builder: (context, state) {
          if (state is FetchUserDetailloading) {
            return CircularProgressIndicator();
          } else if (state is FetchUserDetailsuccess) {
            return ProfilePageAnthorBody(model: state.userModel);
          } else if (state is FetchUserDetailfail) {
            return Text(state.err);
          } else {
            return Text("data");
          }
        },
      ),
    );
  }
}
