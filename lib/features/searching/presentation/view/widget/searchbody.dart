import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/Home/presentation/view/widget/Cutomusername.dart';
import 'package:instagram_app/features/authication/data/manager/fetchuserdetailcubit/fetchuserdetail_cubit.dart';
import 'package:instagram_app/features/authication/presentation/view/widget/Customtextfield.dart';
import 'package:instagram_app/features/profile/presentation/view/profile.dart';
import 'package:instagram_app/features/profileanthoruser/presentation/view/profileanthoruser.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  String? searchtext;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          CustomTextField(
            text: "Search",
            validator: (p0) {},
            onChanged: (p0) {
              setState(() {});
              searchtext = p0;
            },
          ),
          FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .where('username', isEqualTo: searchtext)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () async {
                              await BlocProvider.of<FetchUSerDetailCubit>(
                                      context)
                                  .getdetail(
                                      uid: snapshot.data!.docs[index]['uid']);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePageanthor(),
                              ));
                            },
                            child: CustomUsernameImageandname(
                              name: snapshot.data!.docs[index]['username'],
                              image: snapshot.data!.docs[index]['imageurl'],
                              w: w,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
