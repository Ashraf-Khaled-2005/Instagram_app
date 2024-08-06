import 'package:flutter/material.dart';
import 'package:instagram_app/features/authication/presentation/view_model/usermodel.dart';

class Listtilechat extends StatelessWidget {
  final UserModel userModel;
  const Listtilechat({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(userModel.image),
      ),
      subtitle: Text("Hello"),
      title: Text(
        "${userModel.username}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: (value) async {
          if (value == 'delete') {}
          if (value == 'Block') {}
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text("delete"),
              value: 'delete',
            ),
            PopupMenuItem(
              child: Text("Block"),
              value: "Block",
            ),
          ];
        },
      ),
    );
  }
}
