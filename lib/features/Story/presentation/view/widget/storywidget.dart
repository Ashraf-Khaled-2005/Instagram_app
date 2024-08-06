import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final Map<String, dynamic> story;
  const StoryWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${story['imageurl']}')),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 5)),
          ),
          SizedBox(
            height: 6,
          ),
          Text('${story['username']}')
        ],
      ),
    );
  }
}
