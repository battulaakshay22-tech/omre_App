import 'package:flutter/material.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  String selectedCategory = 'India';
  final categories = ['Following', 'India', 'World', 'Local', 'Business', 'Technology', 'Entertainment', 'Sports', 'Science'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Categories Header
          Container(
            color: theme.scaffoldBackgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      selectedColor: const Color(0xFF2555C8), // App Blue
                      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: isSelected ? Colors.transparent : (isDark ? Colors.grey[700]! : Colors.grey[200]!)),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Hero Section (Featured)
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                       Image.network(
                         'https://picsum.photos/seed/sports/800/600', // Reliable placeholder
                         fit: BoxFit.cover,
                         errorBuilder: (context, error, stackTrace) => Container(
                           color: Colors.grey[900],
                           child: const Center(child: Icon(Icons.broken_image, color: Colors.white54, size: 48)),
                         ),
                       ),
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                _buildBadge('LIVE BREAKING', Colors.red),
                                const SizedBox(width: 8),
                                _buildBadge('Sports', Colors.white.withOpacity(0.3)),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                 const CircleAvatar(
                                   radius: 10,
                                   backgroundColor: Colors.red,
                                   child: Icon(Icons.flash_on, size: 12, color: Colors.white),
                                 ),
                                 const SizedBox(width: 8),
                                 Text(
                                   'Sports Central • 30m ago',
                                   style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                                 ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Indian Cricket Team Announces Squad for Upcoming World Cup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24, 
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Selectors have made some bold choices for the marquee tournament.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 24),
                            const Row(
                              children: [
                                Icon(Icons.favorite_border, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('12.5k', style: TextStyle(color: Colors.white, fontSize: 13)), // Shortened number
                                SizedBox(width: 24),
                                Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text('6.7k', style: TextStyle(color: Colors.white, fontSize: 13)), // Shortened number
                                SizedBox(width: 24),
                                Icon(Icons.share_outlined, color: Colors.white, size: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Text('Top Stories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: theme.textTheme.bodyLarge?.color)),
                const SizedBox(height: 16),
                
                // News List
                _buildNewsItem(
                  title: 'Global Markets Rally as Inflation Data Shows Cooling',
                  source: 'Business Insider',
                  time: '2h ago',
                  imageUrl: 'https://picsum.photos/seed/biz/200', // Business
                  theme: theme,
                  isDark: isDark,
                ),
                _buildNewsItem(
                  title: 'New AI Model Surpasses Human Performance in Medical Diagnosis',
                  source: 'TechCrunch',
                  time: '4h ago',
                  imageUrl: 'https://picsum.photos/seed/tech/200', // Tech
                  theme: theme,
                   isDark: isDark,
                ),
                _buildNewsItem(
                  title: 'SpaceX Successfully Launches Next Gen Starship',
                  source: 'SpaceNews',
                  time: '5h ago',
                  imageUrl: 'https://picsum.photos/seed/space/200', // Space
                  theme: theme,
                   isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  Widget _buildNewsItem({
    required String title,
    required String source,
    required String time,
    required String imageUrl,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 8, backgroundColor: isDark ? Colors.grey[700] : Colors.grey[300]),
                    const SizedBox(width: 8),
                    Text('$source • $time', style: TextStyle(color: theme.hintColor, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.3,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                 Row(
                   children: [
                     Icon(Icons.bookmark_border, size: 20, color: theme.iconTheme.color?.withOpacity(0.5)),
                     const SizedBox(width: 16),
                     Icon(Icons.ios_share_outlined, size: 20, color: theme.iconTheme.color?.withOpacity(0.5)),
                   ],
                 ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: Icon(Icons.broken_image, 
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
