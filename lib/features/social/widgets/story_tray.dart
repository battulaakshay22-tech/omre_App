import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../core/theme/palette.dart';

class StoryTray extends GetView<HomeController> {
  const StoryTray({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: controller.stories.length,
        itemBuilder: (context, index) {
          final storyGroup = controller.stories[index];
          final isMe = storyGroup.username == 'Your Story';
          final hasStory = storyGroup.stories.isNotEmpty;

          return GestureDetector(
            onTap: () {
              if (isMe && !hasStory) {
                Get.toNamed('/add-story');
              } else if (hasStory) {
                Get.toNamed(
                  '/story-viewer',
                  arguments: {'groupIndex': index, 'storyIndex': 0},
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: (hasStory && !storyGroup.allViewed)
                              ? const LinearGradient(
                                  colors: [
                                    AppPalette.accentBlue,
                                    Colors.purpleAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          border: (!hasStory || storyGroup.allViewed)
                              ? Border.all(color: Colors.grey.withOpacity(0.3))
                              : null,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(storyGroup.avatarUrl),
                          ),
                        ),
                      ),
                      if (isMe && !hasStory)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppPalette.accentBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    storyGroup.username,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
