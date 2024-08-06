import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetailstate.dart';
import 'package:instagram_app/features/profile/presentation/view/profile.dart';
import 'package:instagram_app/features/searching/presentation/view/search.dart';

import '../features/Home/presentation/view/Home.dart';
import '../features/addingpost/presentation/view/addpostpage.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  List<Widget> page = [HomePage(), SearchPage(), Addpostpage(), ProfilePage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.red,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24,
                color: Colors.white,
              ),
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ),
              label: "Search",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
              label: "AddPost",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24,
                color: Colors.white,
              ),
              label: "Profile",
              backgroundColor: Colors.black)
        ],
      ),
    );
  }
}
