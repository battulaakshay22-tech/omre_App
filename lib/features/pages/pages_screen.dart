import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesScreen extends StatelessWidget {
  const PagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Pages', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search, color: theme.iconTheme.color), onPressed: () {}),
          IconButton(icon: Icon(Icons.add, color: theme.iconTheme.color), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeroSection(theme, isDark),
          const SizedBox(height: 24),
          Text(
            'Your Pages',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 16),
          _buildPageItem(
            'Tech Insider',
            'Technology & News',
            '125K',
            'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=2070&auto=format&fit=crop',
            isDark,
          ),
          _buildPageItem(
            'Flutter Devs',
            'Community',
            '45K',
            'https://images.unsplash.com/photo-1551033406-611cf9a28f67?q=80&w=1974&auto=format&fit=crop',
            isDark,
          ),
          const SizedBox(height: 24),
          Text(
            'Suggested for You',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
          ),
          const SizedBox(height: 16),
          _buildPageItem(
            'Startup Grind',
            'Business',
            '89K',
            'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=2664&auto=format&fit=crop',
            isDark,
            isSuggested: true,
          ),
          _buildPageItem(
            'Digital Art Gallery',
            'Art & Design',
            '230K',
            'https://images.unsplash.com/photo-1547891654-e66ed7ebb968?q=80&w=2070&auto=format&fit=crop',
            isDark,
            isSuggested: true,
          ),
           _buildPageItem(
            'Global Traveler',
            'Travel',
            '560K',
            'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=2070&auto=format&fit=crop',
            isDark,
            isSuggested: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark 
              ? [Colors.blue[900]!, Colors.purple[900]!] 
              : [Colors.blue[100]!, Colors.purple[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Your Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Share your passion with the world and build a community.',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.white : Colors.blue,
                    foregroundColor: isDark ? Colors.blue : Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
          Icon(Icons.flag, size: 80, color: isDark ? Colors.white24 : Colors.blue.withOpacity(0.2)),
        ],
      ),
    );
  }

  Widget _buildPageItem(String title, String category, String followers, String imageUrl, bool isDark, {bool isSuggested = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '$category • $followers followers',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          if (isSuggested)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Like'),
            )
          else
             IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }
}
