import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:omre/core/constants/app_assets.dart';
import 'package:animations/animations.dart';
import '../../core/services/state_providers.dart';
import '../../core/theme/palette.dart';
import '../../core/routing/router.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/explore/explore_screen.dart';

import '../../features/messenger/messenger_home_screen.dart';
import '../../features/shorts/shorts_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/profile/settings/settings_screen.dart';
import '../../features/biz/biz_home_screen.dart';
import '../../features/jobs/jobs_screen.dart';
import '../../features/education/education_screen.dart';
import '../../features/studio/studio_home_screen.dart';
import '../../features/games/games_home_screen.dart';
import '../../features/meeting/meeting_screen.dart';
import '../../features/pages/pages_screen.dart';
import '../../features/groups/groups_screen.dart';
import '../../features/town_hall/town_hall_screen.dart';
import '../../features/birthday/birthday_screen.dart';
import '../../features/blogs/blogs_screen.dart';
import '../../features/weather/weather_screen.dart';
import '../../features/friends/friends_screen.dart';
import '../../features/video/video_home_screen.dart';
import '../../features/movies/movies_screen.dart';
import '../../features/images/images_screen.dart';

import '../../features/omni_suite/omni_know_screen.dart';
import '../../features/omni_suite/happy_corner_screen.dart';
import '../../features/omni_suite/virtual_world_screen.dart';
import '../../features/omni_suite/digital_citizen_screen.dart';
import '../../features/omni_suite/omni_ai_screen.dart';

class ShellScreen extends GetView<AppController> {
  const ShellScreen({super.key});

  void _onItemTapped(int index) {
    controller.bottomNavIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        
        return Scaffold(
          drawer: _buildDrawer(context, theme, isDark),
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: theme.iconTheme.color),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Obx(() {
                if (controller.isSearching.value) {
                  return TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Search OMRE...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      controller.isSearching.value = false;
                      Get.snackbar('Search', 'Results for "$value" coming soon!');
                    },
                  );
                }
                return PopupMenuButton<AppMode>(
                  initialValue: controller.appMode,
                  onSelected: (mode) {
                    controller.appMode = mode;
                    controller.bottomNavIndex = 0;
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  offset: const Offset(0, 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getModeIcon(controller.appMode), size: 18, color: AppPalette.accentBlue),
                        const SizedBox(width: 8),
                        Text(
                          _getModeLabel(controller.appMode),
                          style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey[600]),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    _buildMenuItem(AppMode.social, 'Social', Icons.people_outline),
                    _buildMenuItem(AppMode.messenger, 'Chat', Icons.chat_bubble_outline),
                    _buildMenuItem(AppMode.biz, 'Biz', Icons.business),
                    _buildMenuItem(AppMode.link, 'Link', Icons.link),
                    _buildMenuItem(AppMode.education, 'Learn', Icons.school_outlined),
                    _buildMenuItem(AppMode.studio, 'Studio', Icons.palette_outlined),
                    _buildMenuItem(AppMode.news, 'News', Icons.article_outlined),
                    _buildMenuItem(AppMode.video, 'Video', Icons.play_circle_outline),
                    _buildMenuItem(AppMode.orbit, 'Orbit', Icons.rocket_launch_outlined),
                    _buildMenuItem(AppMode.games, 'Games', Icons.sports_esports_outlined),
                    _buildMenuItem(AppMode.meeting, 'Meeting', Icons.videocam_outlined),
                  ],
                );
              }),
            ),
            actions: [
              Obx(() => IconButton(
                onPressed: () {
                  controller.isSearching.toggle();
                  if (!controller.isSearching.value) {
                    controller.searchController.clear();
                  }
                },
                icon: Icon(
                  controller.isSearching.value ? Icons.close : Icons.search, 
                  color: theme.iconTheme.color
                ),
              )),
              IconButton(
                onPressed: () {
                  Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
                },
                icon: Icon(isDark ? Icons.light_mode : Icons.wb_sunny_outlined, color: theme.iconTheme.color),
              ),
              Stack(
                children: [
                   IconButton(
                     onPressed: () {
                       Get.to(() => const NotificationsScreen());
                     },
                     icon: Icon(Icons.notifications_outlined, color: theme.iconTheme.color),
                   ),
                   Positioned(
                     top: 8,
                     right: 8,
                     child: Container(
                       width: 8,
                       height: 8,
                       decoration: const BoxDecoration(
                         color: Colors.red,
                         shape: BoxShape.circle,
                       ),
                     ),
                   ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                child: GestureDetector(
                  onTap: () => _onItemTapped(3), // Go to Profile
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(AppAssets.avatar1),
                  ),
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              if (isWide)
                Obx(() => NavigationRail(
                  selectedIndex: controller.bottomNavIndex,
                  onDestinationSelected: _onItemTapped,
                  labelType: NavigationRailLabelType.none,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  selectedIconTheme: const IconThemeData(color: AppPalette.accentBlue),
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
                    NavigationRailDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: Text('Explore')),
                    NavigationRailDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: Text('Inbox')),
                    NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile')),
                  ],
                )),
              Expanded(
                child: Obx(() {
                  final isSocial = controller.appMode == AppMode.social;
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isWide && isSocial ? 600 : 1200),
                      child: _getPageContent(controller.bottomNavIndex),
                    ),
                  );
                }),
              ),
              Obx(() {
                final isSocial = controller.appMode == AppMode.social;
                if (isWide && isSocial) {
                  return Container(
                    width: 300,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey.withOpacity(0.1))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Trending topics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        _SidebarItem(label: '#OMRE_Beta', sublabel: '12.4k posts'),
                        _SidebarItem(label: '#FlutterDev', sublabel: '8.1k posts'),
                        _SidebarItem(label: '#CleanArchitecture', sublabel: '5.2k posts'),
                        const SizedBox(height: 32),
                        const Text('Who to follow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        _FollowItem(name: 'Sarah Drasner', handle: '@sdras'),
                        _FollowItem(name: 'Tim Sneath', handle: '@timsneath'),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
          bottomNavigationBar: !isWide ? Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
              boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   blurRadius: 10,
                   offset: const Offset(0, -5),
                 ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Reduced vertical padding
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home', theme),
                   _buildNavItem(1, Icons.explore_outlined, Icons.explore, 'Explore', theme),
                   _buildNavItem(2, Icons.chat_bubble_outline, Icons.chat_bubble, 'Inbox', theme), // Using Chat Bubble for Inbox
                   _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile', theme),
                ],
              ),
            ),
          ) : null,
        );
      },
    );
  }

  Widget _getPageContent(int index) {
    if (index == 0) {
      switch (controller.appMode) {
        case AppMode.social:
          return const HomeContent();
        case AppMode.biz:
          return const BizHomeScreen();
        case AppMode.link:
          return const JobsScreen();
        case AppMode.education:
          return const EducationScreen();
        case AppMode.studio:
          return const StudioHomeScreen();
        case AppMode.games:
          return const GamesHomeScreen();
        case AppMode.video:
          return const VideoHomeScreen();
        case AppMode.messenger:
          return const MessengerHomeScreen();
        case AppMode.meeting:
          return const MeetingScreen();
        default:
          return const HomeContent();
      }
    }
    switch (index) {
      case 1:
        return const ExploreScreen();
      case 2:
        return const MessengerHomeScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeContent();
    }
  }

  String _getModeLabel(AppMode mode) {
    switch (mode) {
      case AppMode.social: return 'Social';
      case AppMode.messenger: return 'Chat';
      case AppMode.biz: return 'Biz';
      case AppMode.link: return 'Link';
      case AppMode.education: return 'Learn';
      case AppMode.studio: return 'Studio';
      case AppMode.news: return 'News';
      case AppMode.video: return 'Video';
      case AppMode.orbit: return 'Orbit';
      case AppMode.games: return 'Games';
      case AppMode.meeting: return 'Meeting';
    }
  }

  IconData _getModeIcon(AppMode mode) {
    switch (mode) {
      case AppMode.social: return Icons.people_outline;
      case AppMode.messenger: return Icons.chat_bubble_outline;
      case AppMode.biz: return Icons.business;
      case AppMode.link: return Icons.link;
      case AppMode.education: return Icons.school_outlined;
      case AppMode.studio: return Icons.palette_outlined;
      case AppMode.news: return Icons.article_outlined;
      case AppMode.video: return Icons.play_circle_outline;
      case AppMode.orbit: return Icons.rocket_launch_outlined;
      case AppMode.games: return Icons.sports_esports_outlined;
      case AppMode.meeting: return Icons.videocam_outlined;
    }
  }

  PopupMenuItem<AppMode> _buildMenuItem(AppMode mode, String label, IconData icon) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label, ThemeData theme, {bool hasBadge = false}) {
    return Obx(() {
      final isSelected = controller.bottomNavIndex == index;
      return GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? AppPalette.accentBlue : theme.iconTheme.color?.withOpacity(0.6),
                  size: 26, // Slightly reduced size
                ),
                if (hasBadge)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppPalette.accentBlue : theme.iconTheme.color?.withOpacity(0.6),
                fontSize: 10, // Small text size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDrawer(BuildContext context, ThemeData theme, bool isDark) {
    return Drawer(
      backgroundColor: isDark ? Colors.black : theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    isDark ? AppAssets.logoDark : AppAssets.logoLight,
                    height: 40,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20, color: isDark ? Colors.white70 : Colors.grey[500]),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Navigation List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                   _buildDrawerItem(
                     Icons.home_outlined, 
                     'Home', 
                     iconColor: Colors.blue,
                     isActive: controller.bottomNavIndex == 0,
                     isDark: isDark,
                     onTap: () {
                       controller.bottomNavIndex = 0;
                       Navigator.pop(context);
                     },
                   ),
                   _buildDrawerItem(
                     Icons.explore_outlined, 
                     'Explore', 
                     iconColor: Colors.purpleAccent,
                     isActive: controller.bottomNavIndex == 1,
                     isDark: isDark,
                     onTap: () {
                       controller.bottomNavIndex = 1;
                       Navigator.pop(context);
                     },
                   ),
                   _buildDrawerItem(
                     Icons.videocam_outlined, 
                     'Shorts',
                     iconColor: Colors.redAccent,
                     isDark: isDark,
                     onTap: () {
                       Navigator.pop(context);
                       Get.to(() => const ShortsScreen());
                     },
                   ),
                   _buildDrawerItem(
                     Icons.chat_bubble_outline, 
                     'Messages',
                     iconColor: Colors.greenAccent,
                     isActive: controller.bottomNavIndex == 2,
                     isDark: isDark,
                     onTap: () {
                       controller.bottomNavIndex = 2;
                       Navigator.pop(context);
                     },
                   ),
                   _buildDrawerItem(
                     Icons.favorite_border, 
                     'Notifications',
                     iconColor: Colors.pinkAccent,
                     isDark: isDark,
                     onTap: () {
                       Navigator.pop(context);
                       Get.to(() => const NotificationsScreen());
                     },
                   ),
                   _buildDrawerItem(
                     Icons.person_outline, 
                     'Profile', 
                     iconColor: Colors.indigoAccent,
                     isActive: controller.bottomNavIndex == 3,
                     isDark: isDark,
                     onTap: () {
                       controller.bottomNavIndex = 3;
                       Navigator.pop(context);
                     },
                   ),
                   _buildDrawerItem(
                     Icons.settings, 
                     'Settings',
                     iconColor: Colors.grey,
                     isDark: isDark,
                     onTap: () {
                       Navigator.pop(context);
                       Get.to(() => const SettingsScreen());
                     },
                   ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.transparent),
                  ),

                  // Features Section
                  _buildSectionHeader('FEATURES', isDark),
                  _buildDrawerFeatureItem(
                    Icons.lightbulb_outline, 'OmniKnow', Colors.orange, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const OmniKnowScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.sentiment_satisfied_alt, 'Happy Corner', Colors.amber, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const HappyCornerScreen()); }
                  ),
                   _buildDrawerFeatureItem(
                    Icons.language, 'Virtual World', Colors.lightBlue, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const VirtualWorldScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.security_outlined, 'Digital Citizen', Colors.green, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const DigitalCitizenScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.smart_toy_outlined, 'Omni AI', Colors.deepPurpleAccent, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const OmniAIScreen()); }
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.transparent),
                  ),

                  // Social Section
                  _buildSectionHeader('SOCIAL', isDark),
                  _buildDrawerFeatureItem(
                    Icons.article_outlined, 'Pages', Colors.blue, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const PagesScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.groups_outlined, 'Groups', Colors.deepPurple, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const GroupsScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.account_balance_outlined, 'Town Hall', Colors.orange[800]!, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const TownHallScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.cake_outlined, 'Birthday', Colors.pink, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const BirthdayScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.edit_note_outlined, 'Blogs', Colors.green, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const BlogsScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.wb_sunny_outlined, 'Weather', Colors.lightBlue, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const WeatherScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.person_add_outlined, 'Friends', Colors.purpleAccent, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const FriendsScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.live_tv_outlined, 'Watch', Colors.red, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.video;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.movie_outlined, 'Movies', Colors.deepPurpleAccent, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const MoviesScreen()); }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.image_outlined, 'Images', Colors.cyan, isDark,
                    onTap: () { Navigator.pop(context); Get.to(() => const ImagesScreen()); }
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.transparent),
                  ),

                  // Apps Section
                  _buildSectionHeader('APPS', isDark),
                  _buildDrawerFeatureItem(
                    Icons.shopping_bag_outlined, 'Biz', Colors.blue, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.biz;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.work_outline, 'Jobs', Colors.teal, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.link;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.school_outlined, 'Learn', Colors.orange, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.education;
                      controller.bottomNavIndex = 0; 
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.palette_outlined, 'Studio', Colors.purple, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.studio;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.sports_esports_outlined, 'Games', Colors.indigo, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.games;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  _buildDrawerFeatureItem(
                    Icons.videocam_outlined, 'Meeting', Colors.blue, isDark,
                    onTap: () { 
                      controller.appMode = AppMode.meeting;
                      controller.bottomNavIndex = 0;
                      Navigator.pop(context); 
                    }
                  ),
                  
                  const SizedBox(height: 16),
                  _buildDrawerFeatureItem(
                    Icons.logout, 'Logout', Colors.red, isDark,
                    onTap: () { 
                      Navigator.pop(context);
                      Get.offAllNamed('/login'); 
                    }
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, {required Color iconColor, bool isActive = false, VoidCallback? onTap, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive 
            ? (isDark ? Colors.grey[900] : AppPalette.accentBlue.withOpacity(0.1)) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon, 
          color: isActive ? (isDark ? Colors.white : AppPalette.accentBlue) : iconColor,
          size: 24,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? (isDark ? Colors.white : AppPalette.accentBlue) : (isDark ? Colors.grey[400] : Colors.grey[800]),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.grey[600] : Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildDrawerFeatureItem(IconData icon, String label, Color color, bool isDark, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[700],
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      onTap: onTap,
      dense: true,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final String sublabel;
  const _SidebarItem({required this.label, required this.sublabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(sublabel, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }
}

class _FollowItem extends StatelessWidget {
  final String name;
  final String handle;
  const _FollowItem({required this.name, required this.handle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$handle')),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(handle, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Follow', style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}


