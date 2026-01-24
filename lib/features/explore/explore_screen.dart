import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'image_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'For You';
  final categories = ['For You', 'People', 'Posts', 'Video', 'Sound', 'Channels'];

  // Mock data for different categories
  Map<String, List<Map<String, dynamic>>> get _categoryData => {
    'For You': [
      {'url': 'https://picsum.photos/seed/leaf/400/500', 'height': 200.0},
      {'url': 'https://picsum.photos/seed/diver/400/600', 'height': 280.0},
      {'url': 'https://picsum.photos/seed/nature/400/400', 'height': 180.0},
      {'url': 'https://picsum.photos/seed/architecture/400/500', 'height': 260.0},
      {'url': 'https://picsum.photos/seed/tea/400/400', 'height': 220.0},
      {'url': 'https://picsum.photos/seed/balloon/400/400', 'height': 200.0},
    ],
    'People': [
      {'url': 'https://picsum.photos/seed/person1/400/500', 'height': 250.0},
      {'url': 'https://picsum.photos/seed/person2/400/400', 'height': 200.0},
      {'url': 'https://picsum.photos/seed/person3/400/600', 'height': 300.0},
      {'url': 'https://picsum.photos/seed/person4/400/500', 'height': 240.0},
    ],
    'Posts': [
      {'url': 'https://picsum.photos/seed/post1/400/400', 'height': 180.0},
      {'url': 'https://picsum.photos/seed/post2/400/300', 'height': 150.0},
      {'url': 'https://picsum.photos/seed/post3/400/500', 'height': 250.0},
    ],
    // Fallback for others
  };

  List<Map<String, dynamic>> get _currentItems {
    return _categoryData[selectedCategory] ?? _categoryData['For You']!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: theme.iconTheme.color?.withOpacity(0.6), size: 22),
                    const SizedBox(width: 12),
                    Text(
                      'Search OMRE...',
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: categories.map((cat) => _buildCategoryChip(cat, cat == selectedCategory, theme)).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Masonry Grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column 1
                    Expanded(
                      child: Column(
                        children: _currentItems.asMap().entries
                            .where((e) => e.key % 2 == 0)
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _buildImageCard(e.value['url'], height: e.value['height'], isDark: isDark),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Column 2
                    Expanded(
                      child: Column(
                        children: _currentItems.asMap().entries
                            .where((e) => e.key % 2 != 0)
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: _buildImageCard(e.value['url'], height: e.value['height'], isDark: isDark),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, ThemeData theme) {
    final textColor = isSelected ? Colors.white : theme.textTheme.bodyLarge?.color;
    final borderColor = theme.brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[300];

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2555C8) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? Colors.transparent : borderColor!,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, {required double height, required bool isDark}) {
    return GestureDetector(
      onTap: () => Get.to(() => ImageDetailScreen(imageUrl: imageUrl)),
      child: Hero(
        tag: imageUrl,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: height,
              color: isDark ? Colors.grey[800] : Colors.grey[200],
              child: Icon(Icons.broken_image, color: isDark ? Colors.grey[600] : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
