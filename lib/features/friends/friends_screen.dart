import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Friends', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search, color: theme.iconTheme.color), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_add_alt_1, color: theme.iconTheme.color), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRequestSection(theme, isDark),
          const SizedBox(height: 24),
          Text(
            'All Friends (248)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 16),
          _buildFriendItem('Alice Cooper', 'Online', 'https://i.pravatar.cc/150?u=alice', isDark, isOnline: true),
          _buildFriendItem('Bob Smith', 'Last seen 2h ago', 'https://i.pravatar.cc/150?u=bob', isDark),
          _buildFriendItem('Charlie Brown', 'Online', 'https://i.pravatar.cc/150?u=charlie', isDark, isOnline: true),
          _buildFriendItem('Diana Prince', 'Last seen yesterday', 'https://i.pravatar.cc/150?u=diana', isDark),
          _buildFriendItem('Evan Wright', 'Online', 'https://i.pravatar.cc/150?u=evan', isDark, isOnline: true),
          _buildFriendItem('Fiona Gallagher', 'Last seen 4h ago', 'https://i.pravatar.cc/150?u=fiona', isDark),
        ],
      ),
    );
  }

  Widget _buildRequestSection(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Friend Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
            Text('See all', style: TextStyle(color: Colors.blue, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
             color: isDark ? Colors.grey[900] : Colors.white,
             borderRadius: BorderRadius.circular(16),
             border: Border.all(color: Colors.grey.withOpacity(0.1)),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.05),
                 blurRadius: 10,
                 offset: const Offset(0, 4),
               ),
             ],
          ),
          child: Row(
            children: [
              const CircleAvatar(radius: 24, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=request')),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kevin Hart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('12 mutual friends', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.blue, size: 32),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.grey, size: 32),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFriendItem(String name, String status, String imageUrl, bool isDark, {bool isOnline = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          if (isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(status, style: TextStyle(color: isOnline ? Colors.green : Colors.grey, fontSize: 13)),
      trailing: IconButton(
        icon: Icon(Icons.chat_bubble_outline, color: Colors.grey[400]),
        onPressed: () {},
      ),
    );
  }
}
