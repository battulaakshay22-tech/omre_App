import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/mock_service.dart';

class ChatDetailController extends GetxController {
  final messages = <MockMessage>[].obs;
  final textController = TextEditingController();
  final MockChat chat = Get.arguments as MockChat;

  final isSearching = false.obs;
  final searchQueryController = TextEditingController();
  final isMuted = false.obs;
  final wallpaperPath = ''.obs; // Empty string means default wallpaper

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 300), () {
      messages.assignAll(MockService.getMessages(chat.id));
    });
  }

  void sendMessage() {
    if (textController.text.trim().isEmpty) return;

    final newMessage = MockMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: textController.text.trim(),
      isMe: true,
      timestamp: 'Now',
    );

    messages.insert(0, newMessage);
    textController.clear();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQueryController.clear();
    }
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    Get.snackbar(
      isMuted.value ? 'Muted' : 'Unmuted',
      'Notifications for ${chat.name} are now ${isMuted.value ? 'off' : 'on'}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void setWallpaper(String? path) {
    if (path == null) {
      wallpaperPath.value = '';
    } else {
      wallpaperPath.value = path;
    }
    Get.back(); // Close bottom sheet
    Get.snackbar(
      'Wallpaper Updated', 
      'Chat background has been changed',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void handleAttachment(String type) {
    Get.back(); // Close bottom sheet
    
    String messageText = '';
    String icon = '';
    
    switch (type) {
      case 'Document':
        messageText = '📄 Project_Specs.pdf (2.4 MB)';
        break;
      case 'Gallery':
        messageText = '📷 Photo';
        break;
      case 'Audio':
        messageText = '🎤 Voice Message (0:15)';
        break;
      case 'Location':
        messageText = '📍 Shared Location';
        break;
      case 'Contact':
        messageText = '👤 John Doe';
        break;
    }

    if (messageText.isNotEmpty) {
      // Simulate sending the attachment
      Future.delayed(const Duration(milliseconds: 500), () {
        final newMessage = MockMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: messageText,
          isMe: true,
          timestamp: 'Now',
        );
        messages.insert(0, newMessage);
      });
      
      Get.snackbar(
        'Sending $type',
        'Simulating upload...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
      );
    }
  }
}
