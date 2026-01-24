import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Blogs', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeaturedBlog(theme, isDark),
          const SizedBox(height: 32),
          Text(
            'Latest Articles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 16),
          _buildBlogItem(
            'The Future of Flutter in 2026',
            'Technology',
            '5 min read',
            'https://images.unsplash.com/photo-1551033406-611cf9a28f67?q=80&w=1974&auto=format&fit=crop',
            isDark,
          ),
          _buildBlogItem(
            'Sustainable Living: A Weekly Guide',
            'Lifestyle',
            '8 min read',
            'https://images.unsplash.com/photo-1542601906990-b4d3fb7d5afa?q=80&w=2662&auto=format&fit=crop',
            isDark,
          ),
          _buildBlogItem(
            'Portrait Photography Masterclass',
            'Photography',
            '12 min read',
            'https://images.unsplash.com/photo-1554048612-387768052bf7?q=80&w=2080&auto=format&fit=crop',
            isDark,
          ),
           _buildBlogItem(
            'Top 10 Hidden Gems in Japan',
            'Travel',
            '6 min read',
            'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?q=80&w=2070&auto=format&fit=crop',
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBlog(ThemeData theme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1499750310159-525446b095ef?q=80&w=2070&auto=format&fit=crop', // Laptop/Coffee
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Featured', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(height: 12),
                const Text(
                  '10 Habits of Highly Productive Developers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Unlocking peak performance requires more than just coding skills. Here is a breakdown of...',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=blog'),
                    ),
                    const SizedBox(width: 8),
                    const Text('Alex Johnson', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text('Oct 24 • 4 min read', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogItem(String title, String category, String readTime, String imageUrl, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(readTime, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    const Spacer(),
                    Icon(Icons.bookmark_border, size: 20, color: Colors.grey[400]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
