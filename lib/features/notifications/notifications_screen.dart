
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.snackbar('Notifications', 'All notifications marked as read.');
            },
            child: const Text('Mark all as read', style: TextStyle(color: AppPalette.accentBlue)),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Today'),
          _buildNotificationItem(
            type: NotificationType.friendRequest,
            username: 'Sarah Jenkins',
            message: 'sent you a friend request.',
            time: '2h ago',
            avatarUrl: 'https://i.pravatar.cc/150?u=sarah',
            isRead: false,
          ),
          _buildNotificationItem(
            type: NotificationType.like,
            username: 'Marcus Chen',
            message: 'liked your post.',
            time: '4h ago',
            avatarUrl: 'https://i.pravatar.cc/150?u=marcus',
            isRead: false,
            contentPreview: 'Hey everyone, check out my new project!',
          ),
          _buildNotificationItem(
            type: NotificationType.comment,
            username: 'Elena Rodriguez',
            message: 'commented on your photo: "Wow, amazing shot! 🔥"',
            time: '6h ago',
            avatarUrl: 'https://i.pravatar.cc/150?u=elena',
            isRead: true,
          ),
          
          _buildSectionHeader('Yesterday'),
          _buildNotificationItem(
            type: NotificationType.mention,
            username: 'Tech Insider',
            message: 'mentioned you in a post: "Highly recommending @alexj_design for the project!"',
            time: '1d ago',
            avatarUrl: 'https://i.pravatar.cc/150?u=tech',
            isRead: true,
          ),
          _buildNotificationItem(
            type: NotificationType.groupInvite,
            username: 'Flutter Devs',
            message: 'invited you to join their group.',
            time: '1d ago',
            avatarUrl: 'https://i.pravatar.cc/150?u=flutter',
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required NotificationType type,
    required String username,
    required String message,
    required String time,
    required String avatarUrl,
    bool isRead = true,
    String? contentPreview,
  }) {
    return InkWell(
      onTap: () {
        Get.snackbar('Notification', 'Viewing details for this notification...');
      },
      child: Container(
        color: isRead ? Colors.transparent : AppPalette.accentBlue.withOpacity(0.05),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getIconColor(type),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(_getIcon(type), size: 10, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: message),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        time,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      if (!isRead) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppPalette.accentBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (type == NotificationType.friendRequest) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.snackbar(
                              'Success', 
                              'Friend request from $username accepted!',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.accentBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Accept'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            Get.snackbar(
                              'Removed', 
                              'Friend request from $username declined.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Decline'),
                        ),
                      ],
                    ),
                  ],
                  if (contentPreview != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        contentPreview,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700], fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.like: return Icons.favorite;
      case NotificationType.comment: return Icons.chat_bubble;
      case NotificationType.friendRequest: return Icons.person_add;
      case NotificationType.mention: return Icons.alternate_email;
      case NotificationType.groupInvite: return Icons.group_add;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.like: return Colors.red;
      case NotificationType.comment: return Colors.blue;
      case NotificationType.friendRequest: return Colors.green;
      case NotificationType.mention: return Colors.orange;
      case NotificationType.groupInvite: return Colors.purple;
    }
  }
}

enum NotificationType {
  like,
  comment,
  friendRequest,
  mention,
  groupInvite,
}
