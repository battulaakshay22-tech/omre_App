import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/chat_list_item.dart';
import 'new_chat_screen.dart';
import '../../core/services/mock_service.dart';
import '../../core/theme/palette.dart';

class MessengerHomeScreen extends StatefulWidget {
  const MessengerHomeScreen({super.key});

  @override
  State<MessengerHomeScreen> createState() => _MessengerHomeScreenState();
}

class _MessengerHomeScreenState extends State<MessengerHomeScreen> {
  String selectedTab = 'Private';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Assuming dark mode for the specific design requested
    // but sticking to theme context for flexibility where possible or hardcoding if requested specific visuals
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      color: bgColor,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => const NewChatScreen(), transition: Transition.downToUp);
                  },
                  icon: Icon(Icons.add, color: textColor),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  hintText: 'Search messages',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Custom Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                _buildTabPill('Private', count: MockService.chats.where((c) => c.category == 'Private').length),
                const SizedBox(width: 12),
                _buildTabPill('Social', count: MockService.chats.where((c) => c.category == 'Social').length),
                const SizedBox(width: 12),
                _buildTabPill('Pulse', count: MockService.chats.where((c) => c.category == 'Pulse').length),
              ],
            ),
          ),

          // Progress Indicator Line (Optional styling detail from screenshot)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 16, bottom: 8),
              width: 120, // Approximate width for the "Private" tab underline effect if desired, 
                          // or just a separator. The screenshot has a white bar under "Private".
              height: 2,
              color: Colors.transparent, // Hiding for now unless specifically requested to replicate the underline tab style EXACTLY. 
              // Actually, looking at screenshot, there is a white bar under "Private". 
              // But the pills are also distinct. Let's stick to pills for now as they are distinct.
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: MockService.chats.where((c) => c.category == selectedTab && c.name.toLowerCase().contains(_searchQuery.toLowerCase())).length,
              itemBuilder: (context, index) {
                final filteredChats = MockService.chats.where((c) => c.category == selectedTab && c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
                final chat = filteredChats[index];
                return ChatListItem(
                  chat: chat,
                  onTap: () {
                    Get.toNamed('/chat-detail', arguments: chat);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(String label, {int? count}) {
    final isSelected = selectedTab == label;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isDark ? const Color(0xFF2C2C2C) : Colors.black) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.transparent), // Clean look
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (count != null && count > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF3B4553), // Dark blue-ish grey badge
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.blueAccent, 
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
