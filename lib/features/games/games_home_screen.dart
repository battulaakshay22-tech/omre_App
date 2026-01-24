import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/games_controller.dart';

class GamesHomeScreen extends StatefulWidget {
  const GamesHomeScreen({super.key});

  @override
  State<GamesHomeScreen> createState() => _GamesHomeScreenState();
}

class _GamesHomeScreenState extends State<GamesHomeScreen> {
  String selectedTab = 'Overview';
  final tabs = ['Overview', 'Live Now', 'Clips', 'Squad Finder', 'Tournaments', 'Library'];
  final controller = Get.put(GamesController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.sports_esports, color: Color(0xFF3B82F6), size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 20, color: theme.iconTheme.color?.withOpacity(0.6)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Find games, players, or clips...',
                              style: TextStyle(color: theme.hintColor, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('LVL 42', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF3B82F6))),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[700] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(2),
                        ),
                         child: Align(
                           alignment: Alignment.centerLeft,
                           child: Container(
                             width: 32,
                             height: 4,
                             decoration: BoxDecoration(
                               color: const Color(0xFF3B82F6),
                               borderRadius: BorderRadius.circular(2),
                             ),
                           ),
                         ),
                      ),
                    ],
                  ),
                   const SizedBox(width: 12),
                   ElevatedButton(
                     onPressed: () {},
                     style: ElevatedButton.styleFrom(
                       backgroundColor: const Color(0xFF2555C8),
                       foregroundColor: Colors.white,
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       minimumSize: Size.zero,
                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                     ),
                     child: const Row(
                       children: [
                         Icon(Icons.add, size: 16, color: Colors.white),
                         SizedBox(width: 4),
                         Text('Post', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                       ],
                     ),
                   ),
                ],
              ),
            ),
            
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = tab == selectedTab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = tab;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            tab,
                            style: TextStyle(
                              color: isSelected ? (isDark ? Colors.white : Colors.black) : theme.hintColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 2,
                              width: 20,
                              color: const Color(0xFF3B82F6),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
            
            // Content
            Expanded(
              child: _buildBodyContent(controller, theme, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent(GamesController controller, ThemeData theme, bool isDark) {
    if (selectedTab == 'Live Now') {
      return Obx(() => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Full width for details, or 2 for density. Channel card is wide.
          mainAxisSpacing: 16,
          childAspectRatio: 240/220, // Adjust based on card size
        ),
        itemCount: controller.liveChannels.length,
        itemBuilder: (context, index) {
          final channel = controller.liveChannels[index];
          return GestureDetector(
            onTap: () => controller.openStream(channel),
            child: _buildChannelCard(
              image: channel['image'],
              title: channel['title'],
              streamer: channel['streamer'],
              tags: List<String>.from(channel['tags']),
              theme: theme,
              isDark: isDark,
              width: double.infinity,
            ),
          );
        },
      ));
    } else if (selectedTab == 'Clips') {
      return Obx(() => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 160/240,
        ),
        itemCount: controller.trendingClips.length,
        itemBuilder: (context, index) {
          final clip = controller.trendingClips[index];
          return GestureDetector(
            onTap: () => controller.openClip(clip),
            child: _buildClipCard(clip),
          );
        },
      ));
    } else if (selectedTab == 'Overview') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Card (Featured Stream)
            Obx(() {
                final featured = controller.featuredStream;
                return GestureDetector(
                  onTap: () => controller.openStream(featured),
                  child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(featured['image'] as String), 
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                                  child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                                  child: Text(featured['viewers'] as String, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(featured['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(radius: 12, backgroundImage: AssetImage(featured['avatar'] as String)),
                                    const SizedBox(width: 8),
                                    Text(featured['streamer'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                                      child: Text(featured['category'] as String, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                );
            }),
            
            const SizedBox(height: 24),
            
            // Live Channels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.videocam_outlined, color: Colors.pink, size: 20),
                    const SizedBox(width: 8),
                    Text('Live Channels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.textTheme.bodyLarge?.color)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 'Live Now';
                    });
                  },
                  child: Text('View All', style: TextStyle(color: Colors.blue[600], fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                children: controller.liveChannels.map((channel) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => controller.openStream(channel),
                        child: _buildChannelCard(
                          image: channel['image'],
                          title: channel['title'],
                          streamer: channel['streamer'],
                          tags: List<String>.from(channel['tags']),
                          theme: theme,
                          isDark: isDark,
                        ),
                      ),
                    );
                }).toList(),
              )),
            ),
            
            const SizedBox(height: 24),
            
            // Trending Clips
            Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text('Trending Clips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.textTheme.bodyLarge?.color)),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                children: controller.trendingClips.map((clip) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => controller.openClip(clip),
                      child: _buildClipCard(clip),
                    ),
                  );
                }).toList(),
              )),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: isDark ? Colors.white24 : Colors.black12),
            const SizedBox(height: 16),
            Text('Coming Soon', style: TextStyle(color: theme.hintColor, fontSize: 16)),
          ],
        ),
      );
    }
  }
  
  Widget _buildChannelCard({
    required String image,
    required String title,
    required String streamer,
    required List<String> tags,
    required ThemeData theme,
    required bool isDark,
    double? width,
  }) {
    return Container(
      width: width ?? 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textTheme.bodyLarge?.color), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(streamer, style: TextStyle(color: theme.hintColor, fontSize: 11)),
          const SizedBox(height: 8),
          Row(
            children: tags.map((tag) => Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
              ),
              child: Text(tag, style: TextStyle(fontSize: 10, color: theme.hintColor)),
            )).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildClipCard(Map<String, dynamic> clip) {
    return Container(
      width: 160,
      height: 240, // Vertical phone aspect mostly
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(clip['image']),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
              child: Text(clip['duration'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(clip['title'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                 const SizedBox(height: 2),
                 Text(clip['creator'], style: const TextStyle(color: Colors.white70, fontSize: 10)),
              ],
            ),
          ),
          const Center(
            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 48),
          )
        ],
      ),
    );
  }
}
