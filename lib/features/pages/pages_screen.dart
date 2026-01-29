import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'package:get/get.dart';
import 'screens/create_page_screen.dart';
import 'screens/page_detail_screen.dart';

class PagesScreen extends StatelessWidget {
  const PagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);

    return stopBuild(theme, isDark, bgColor, context);
  }

  Widget stopBuild(ThemeData theme, bool isDark, Color bgColor, BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Pages', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: isDark ? const Color(0xFF242526) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Get.back(),
          ),
          actions: [
             IconButton(icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black), onPressed: () {}),
          ],
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
            indicatorColor: Colors.blue,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Your Pages'),
              Tab(text: 'Discover'),
              Tab(text: 'Invites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildYourPagesTab(theme, isDark),
            _buildDiscoverTab(theme, isDark),
            _buildInvitesTab(theme, isDark),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: YOUR PAGES ---
  Widget _buildYourPagesTab(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCreatePageButton(isDark),
          const SizedBox(height: 24),
          Text('Pages details', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPageTile('Tech Insider', 'Technology • 12 Notifications', AppAssets.post1, isDark),
          _buildPageTile('Flutter Devs', 'Community • 5 New Messages', AppAssets.post2, isDark),
          _buildPageTile('My Startup', 'Business • Publish a post', AppAssets.post3, isDark),
        ],
      ),
    );
  }

  // --- TAB 2: DISCOVER ---
  Widget _buildDiscoverTab(ThemeData theme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryChip('Business', true),
              _buildCategoryChip('Music', false),
              _buildCategoryChip('Sports', false),
              _buildCategoryChip('Gaming', false),
              _buildCategoryChip('Art', false),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Suggested Pages', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        const SizedBox(height: 12),
        _buildSuggestedPageCard('SpaceX Fans', 'Science & Tech', AppAssets.post4, AppAssets.cover1, isDark),
        _buildSuggestedPageCard('Healthy Living', 'Health & Wellness', AppAssets.post5, AppAssets.cover2, isDark),
        _buildSuggestedPageCard('Modern Architecture', 'Design', AppAssets.post1, AppAssets.cover3, isDark),
      ],
    );
  }

  // --- TAB 3: INVITES ---
  Widget _buildInvitesTab(ThemeData theme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Page Invites', 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)
        ),
        const SizedBox(height: 4),
        Text('2 new invites', style: TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildInviteCard('John invited you to like', 'Guitar Masters', 'Music', AppAssets.avatar3, AppAssets.post2, isDark),
        _buildInviteCard('Sarah invited you to like', 'Digital Nomads', 'Travel', AppAssets.avatar1, AppAssets.post3, isDark),
      ],
    );
  }

  // --- SUB-WIDGETS ---

  Widget _buildCreatePageButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => const CreatePageScreen());
        },
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Create New Page'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
          foregroundColor: isDark ? Colors.white : Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: isDark ? null : const BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
    );
  }

  Widget _buildPageTile(String title, String subtitle, String img, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242526) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(radius: 28, backgroundImage: AssetImage(img)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Container(
          width: 10, height: 10,
          decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        ),
        onTap: () {
          Get.to(() => PageDetailScreen(
            title: title,
            category: 'Page Category',
            followers: '10K Followers',
            image: img,
            cover: AppAssets.cover1,
            isJoined: true,
          ));
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        backgroundColor: Colors.grey.withOpacity(0.1),
        selectedColor: Colors.blue.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.grey,
          fontWeight: FontWeight.bold
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      ),
    );
  }

  Widget _buildSuggestedPageCard(String title, String category, String avatar, String cover, bool isDark) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PageDetailScreen(
          title: title,
          category: category,
          followers: '5K Followers',
          image: avatar,
          cover: cover,
          isJoined: false,
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF242526) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(cover, height: 100, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 10, left: 16,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: isDark ? const Color(0xFF242526) : Colors.white,
                    child: CircleAvatar(radius: 27, backgroundImage: AssetImage(avatar)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                        Text(category, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar('Success', 'Liked $title', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blue, colorText: Colors.white);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      foregroundColor: isDark ? Colors.white : Colors.black,
                      elevation: 0,
                    ),
                    child: const Text('Like'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteCard(String info, String pageName, String category, String userImg, String pageImg, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242526) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundImage: AssetImage(userImg)),
              const SizedBox(width: 8),
              Text(info, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(pageImg, width: 50, height: 50, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pageName, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                    Text(category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                     Get.snackbar('Accepted', 'You liked $pageName', snackPosition: SnackPosition.BOTTOM);
                  }, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, elevation: 0),
                  child: const Text('Accept', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                     Get.snackbar('Declined', 'Invite removed', snackPosition: SnackPosition.BOTTOM);
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.1), 
                    foregroundColor: isDark ? Colors.white : Colors.black,
                    elevation: 0,
                  ),
                  child: const Text('Decline'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
