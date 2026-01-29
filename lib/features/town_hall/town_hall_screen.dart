import 'package:flutter/material.dart';
import 'package:omre/core/constants/app_assets.dart';
import 'package:get/get.dart';

class TownHallScreen extends StatelessWidget {
  const TownHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);
    final cardColor = isDark ? const Color(0xFF242526) : Colors.white;
    final iconColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Town Hall', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: cardColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: isDark ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Contact Your Reps Section (Facebook Town Hall style)
            Container(
              color: cardColor,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Your Representatives',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildRepCard('Mayor Office', 'City Hall', AppAssets.avatar1, isDark),
                        _buildRepCard('Edu. Board', 'District 9', AppAssets.avatar2, isDark),
                        _buildRepCard('Public Works', 'City Dept.', AppAssets.avatar3, isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8), // Spacer

            // Feed of Discussions/Votes
            _buildSectionHeader('Community Discussions', isDark),
            
            _buildPostCard(
              context: context,
              avatar: AppAssets.avatar1,
              name: 'Mayor\'s Office',
              time: '2 hrs ago',
              title: 'City Infrastructure Plan 2026',
              content: 'We are discussing the new subway lines and road improvements for the downtown area. Join the live Q&A session now!',
              imageUrl: AppAssets.post1,
              stats: '1.2K participating • 500 comments',
              isLive: true,
              isDark: isDark,
            ),

             _buildPostCard(
              context: context,
              avatar: AppAssets.avatar2,
              name: 'Education Board',
              time: '5 hrs ago',
              title: 'School District Budget Vote',
              content: 'Should we allocate more funds to the science department or the arts program? Cast your vote below.',
              imageUrl: AppAssets.post2,
              stats: '450 votes • 120 comments',
              hasVote: true,
              voteProgress: 0.7,
              isDark: isDark,
            ),

            _buildPostCard(
              context: context,
              avatar: AppAssets.avatar3,
              name: 'Community Watch',
              time: 'Yesterday',
              title: 'Neighborhood Safety Meeting',
              content: 'Annual meeting to discuss street lighting and patrol schedules. Everyone is welcome.',
              imageUrl: AppAssets.cover1,
              stats: '89 attending',
              isDark: isDark,
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      color: isDark ? const Color(0xFF242526) : Colors.transparent,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.grey[300] : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildRepCard(String name, String role, String avatar, bool isDark) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(avatar),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            role,
            style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Contact', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard({
    required BuildContext context,
    required String avatar,
    required String name,
    required String time,
    required String title,
    required String content,
    String? imageUrl,
    required String stats,
    bool isLive = false,
    bool hasVote = false,
    double voteProgress = 0.0,
    required bool isDark,
  }) {
    final cardColor = isDark ? const Color(0xFF242526) : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(avatar)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black)),
                      Row(
                        children: [
                          Text(time, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12)),
                          const SizedBox(width: 4),
                          Icon(Icons.public, size: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ],
            ),
          ),

          // Content Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isLive)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Text('LIVE DISCUSSION', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black)),
                const SizedBox(height: 4),
                Text(content, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Media / Vote
          if (imageUrl != null)
            Image.asset(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
          
          if (hasVote)
             Padding(
               padding: const EdgeInsets.all(12),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(8),
                     child: LinearProgressIndicator(
                       value: voteProgress,
                       minHeight: 10,
                       backgroundColor: isDark ? Colors.grey[700] : Colors.grey[200],
                       color: Colors.blue,
                     ),
                   ),
                   const SizedBox(height: 8),
                   Text('70% Voted Yes', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                 ],
               ),
             ),


          // Stats
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                Text(stats, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),

          // Action Buttons
          const Divider(height: 1),
          Row(
            children: [
              _buildActionButton(Icons.thumb_up_outlined, 'Like', isDark),
              _buildActionButton(Icons.chat_bubble_outline, 'Comment', isDark),
              _buildActionButton(Icons.share_outlined, 'Share', isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isDark) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
