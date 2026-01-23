import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/story_tray.dart';
import 'widgets/post_card.dart';
import 'widgets/create_post_widget.dart';
import 'widgets/feed_toggle_widget.dart';
import 'controllers/home_controller.dart';

class SocialHomeScreen extends GetView<HomeController> {
  const SocialHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const StoryTray(),
        const Divider(height: 1, thickness: 0.5),
        const CreatePostWidget(),
        const FeedToggleWidget(),
        const SizedBox(height: 8),
        Obx(() => Column(
          children: controller.displayPosts.map((post) => PostCard(post: post)).toList(),
        )),
      ],
    );
  }
}
