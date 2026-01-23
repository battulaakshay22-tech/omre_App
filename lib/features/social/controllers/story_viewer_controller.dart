import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/social_models.dart';
import './home_controller.dart';

class StoryViewerController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  
  final groupIndex = 0.obs;
  final storyIndex = 0.obs;
  final progress = 0.0.obs;
  Timer? _timer;

  final messageController = TextEditingController();
  final isPaused = false.obs;
  
  UserStoryGroup get currentGroup => homeController.stories[groupIndex.value];
  StoryModel get currentStory => currentGroup.stories[storyIndex.value];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      groupIndex.value = args['groupIndex'] ?? 0;
      storyIndex.value = args['storyIndex'] ?? 0;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Validate that the current indices point to a valid story
      if (!_isValidIndex()) {
        // Try to find the first valid story
        if (!_findFirstValidStory()) {
          // If no stories at all, close the viewer
          Get.back();
          return;
        }
      }

      _startTimer();
      _markAsViewed();
    });
  }

  bool _isValidIndex() {
    if (groupIndex.value < 0 || groupIndex.value >= homeController.stories.length) {
      return false;
    }
    final group = homeController.stories[groupIndex.value];
    if (storyIndex.value < 0 || storyIndex.value >= group.stories.length) {
      return false;
    }
    return true;
  }

  bool _findFirstValidStory() {
    for (int i = 0; i < homeController.stories.length; i++) {
      if (homeController.stories[i].stories.isNotEmpty) {
        groupIndex.value = i;
        storyIndex.value = 0;
        return true;
      }
    }
    return false;
  }

  @override
  void onClose() {
    _timer?.cancel();
    messageController.dispose();
    super.onClose();
  }

  void pauseTimer() {
    isPaused.value = true;
  }

  void resumeTimer() {
    isPaused.value = false;
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    Get.snackbar(
      'Message Sent',
      'You replied: $text',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
    messageController.clear();
    resumeTimer(); // Resume if paused for typing
  }

  void sendReaction(String emoji) {
    if (emoji == '❤️') {
      toggleLike();
      return;
    }
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        'Reacted with $emoji',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 300),
    ));
  }

  void toggleLike() {
    currentStory.isLiked.toggle();
    // Optional: Show feedback only when liking, or maybe a small animation
    if (currentStory.isLiked.value) {
      Get.showSnackbar(GetSnackBar(
        messageText: const Text(
          '❤️ Liked',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(milliseconds: 300),
      ));
    }
  }



  void shareStory() {
    // paused logic can be added here if needed
    Get.showSnackbar(const GetSnackBar(
      messageText: Text(
        '🔗 Custom Share Dialog / Sheet',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: 2),
      animationDuration: Duration(milliseconds: 300),
    ));
  }

  void _startTimer() {
    _timer?.cancel();
    progress.value = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (isPaused.value) return; // Don't advance if paused
      
      progress.value += 0.01;
      if (progress.value >= 1.0) {
        nextStory();
      }
    });
  }

  void nextStory() {
    if (storyIndex.value < currentGroup.stories.length - 1) {
      storyIndex.value++;
      _startTimer();
      _markAsViewed();
    } else {
      nextUser();
    }
  }

  void previousStory() {
    if (storyIndex.value > 0) {
      storyIndex.value--;
      _startTimer();
      _markAsViewed();
    } else {
      previousUser();
    }
  }

  void nextUser() {
    int newGroupIndex = groupIndex.value + 1;
    while (newGroupIndex < homeController.stories.length &&
        homeController.stories[newGroupIndex].stories.isEmpty) {
      newGroupIndex++;
    }

    if (newGroupIndex < homeController.stories.length) {
      groupIndex.value = newGroupIndex;
      storyIndex.value = 0;
      _startTimer();
      _markAsViewed();
    } else {
      Get.back();
    }
  }

  void previousUser() {
    int newGroupIndex = groupIndex.value - 1;
    while (newGroupIndex >= 0 &&
        homeController.stories[newGroupIndex].stories.isEmpty) {
      newGroupIndex--;
    }

    if (newGroupIndex >= 0) {
      groupIndex.value = newGroupIndex;
      storyIndex.value =
          homeController.stories[groupIndex.value].stories.length - 1;
      _startTimer();
      _markAsViewed();
    } else {
      Get.back();
    }
  }

  void _markAsViewed() {
    currentStory.isViewed.value = true;
    homeController.stories.refresh();
  }
}
