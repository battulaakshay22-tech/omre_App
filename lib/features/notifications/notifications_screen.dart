
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import 'notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.put(NotificationsController());

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Notifications', 
          style: TextStyle(fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color)
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: controller.markAllAsRead,
            child: const Text('Mark all as read', style: TextStyle(color: AppPalette.accentBlue)),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off_outlined, size: 64, color: isDark ? Colors.white24 : Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'No notifications yet',
                   style: TextStyle(color: theme.hintColor, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Dismissible(
              key: Key(notification.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => controller.removeNotification(notification.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: _buildNotificationItem(
                context,
                notification,
                controller,
                isDark,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationItem notification,
    NotificationsController controller,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        controller.markAsRead(notification.id);
        // Navigate or show details
      },
      child: Container(
        color: notification.isRead 
            ? Colors.transparent 
            : (isDark ? AppPalette.accentBlue.withOpacity(0.1) : AppPalette.accentBlue.withOpacity(0.05)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(notification.avatarUrl),
                  backgroundColor: Colors.grey[800],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getIconColor(notification.type),
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                    ),
                    child: Icon(_getIcon(notification.type), size: 10, color: Colors.white),
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
                      style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
                      children: [
                        TextSpan(
                          text: notification.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: notification.message),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        notification.time,
                        style: TextStyle(fontSize: 12, color: theme.hintColor),
                      ),
                      if (!notification.isRead) ...[
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
                  if (notification.type == NotificationType.friendRequest) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => controller.acceptRequest(notification.id, notification.username),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.accentBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            minimumSize: const Size(0, 32),
                          ),
                          child: const Text('Accept', style: TextStyle(fontSize: 13)),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => controller.declineRequest(notification.id, notification.username),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.textTheme.bodyMedium?.color,
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.grey[300]!),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            minimumSize: const Size(0, 32),
                          ),
                          child: const Text('Decline', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  ],
                  if (notification.contentPreview != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                      ),
                      child: Text(
                        notification.contentPreview!,
                        style: TextStyle(fontSize: 12, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8), fontStyle: FontStyle.italic),
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
