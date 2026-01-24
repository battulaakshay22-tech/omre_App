import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';

enum NotificationType {
  like,
  comment,
  friendRequest,
  mention,
  groupInvite,
}

class NotificationsController extends GetxController {
  final notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.assignAll([
      NotificationItem(
        id: '1',
        type: NotificationType.friendRequest,
        username: 'Sarah Jenkins',
        message: 'sent you a friend request.',
        time: '2h ago',
        avatarUrl: AppAssets.avatar1,
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        type: NotificationType.like,
        username: 'Marcus Chen',
        message: 'liked your post.',
        time: '4h ago',
        avatarUrl: AppAssets.avatar2,
        isRead: false,
        contentPreview: 'Hey everyone, check out my new project!',
      ),
      NotificationItem(
        id: '3',
        type: NotificationType.comment,
        username: 'Elena Rodriguez',
        message: 'commented on your photo: "Wow, amazing shot! 🔥"',
        time: '6h ago',
        avatarUrl: AppAssets.avatar3,
        isRead: true,
      ),
      NotificationItem(
        id: '4',
        type: NotificationType.mention,
        username: 'Tech Insider',
        message: 'mentioned you in a post: "Highly recommending @alexj_design for the project!"',
        time: '1d ago',
        avatarUrl: AppAssets.avatar4,
        isRead: true,
      ),
      NotificationItem(
        id: '5',
        type: NotificationType.groupInvite,
        username: 'Flutter Devs',
        message: 'invited you to join their group.',
        time: '1d ago',
        avatarUrl: AppAssets.avatar5,
        isRead: true,
      ),
    ]);
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  void markAllAsRead() {
    final updated = notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifications.assignAll(updated);
    Get.snackbar('Notifications', 'All notifications marked as read.');
  }

  void removeNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  void acceptRequest(String id, String username) {
    // In a real app, call API here
    removeNotification(id);
    Get.snackbar('Success', 'Friend request from $username accepted!',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
  }

  void declineRequest(String id, String username) {
    // In a real app, call API here
    removeNotification(id);
    Get.snackbar('Removed', 'Friend request from $username declined.',
        snackPosition: SnackPosition.BOTTOM);
  }
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String username;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isRead;
  final String? contentPreview;

  NotificationItem({
    required this.id,
    required this.type,
    required this.username,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.isRead,
    this.contentPreview,
  });

  NotificationItem copyWith({
    String? id,
    NotificationType? type,
    String? username,
    String? message,
    String? time,
    String? avatarUrl,
    bool? isRead,
    String? contentPreview,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      username: username ?? this.username,
      message: message ?? this.message,
      time: time ?? this.time,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isRead: isRead ?? this.isRead,
      contentPreview: contentPreview ?? this.contentPreview,
    );
  }
}
