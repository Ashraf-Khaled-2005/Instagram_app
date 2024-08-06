import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";

class Storyview extends StatefulWidget {
  final Map<String, dynamic> story;
  const Storyview({super.key, required this.story});

  @override
  State<Storyview> createState() => _StoryviewState();
}

class _StoryviewState extends State<Storyview> {
  final StoryController controller = StoryController();
  @override
  Widget build(BuildContext context) {
    List stories = widget.story['stories'];
    return Scaffold(
        body: StoryView(
            repeat: false,
            onComplete: () => Navigator.pop(context),
            controller: controller,
            storyItems: stories.map((e) {
              if (e['type'] == 'image') {
                return StoryItem.pageImage(
                    url: e['content'], controller: controller);
              } else {
                return StoryItem.pageVideo(e['content'],
                    controller: controller);
              }
            }).toList()));
  }
}
