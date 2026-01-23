import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
                children: [
                  _buildCategoryChip('For You', true, theme),
                  _buildCategoryChip('People', false, theme),
                  _buildCategoryChip('Posts', false, theme),
                  _buildCategoryChip('Video', false, theme),
                  _buildCategoryChip('Sound', false, theme),
                  _buildCategoryChip('Channels', false, theme),
                ],
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
                        children: [
                          _buildImageCard(
                            'https://picsum.photos/seed/leaf/400/500', // Leaf
                            height: 200,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          _buildImageCard(
                            'https://picsum.photos/seed/diver/400/600', // Underwater/Diver
                            height: 280,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                           _buildImageCard(
                            'https://picsum.photos/seed/nature/400/400', // Landscape
                            height: 180,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Column 2
                    Expanded(
                      child: Column(
                        children: [
                          _buildImageCard(
                            'https://picsum.photos/seed/architecture/400/500', // Architecture
                            height: 260,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          _buildImageCard(
                            'https://picsum.photos/seed/tea/400/400', // Meeting/Teapot context
                            height: 220,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          _buildImageCard(
                            'https://picsum.photos/seed/balloon/400/400', // Balloon/Travel
                            height: 200,
                            isDark: isDark,
                          ),
                        ],
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
    // Determine text color: White if selected, otherwise theme body color
    final textColor = isSelected ? Colors.white : theme.textTheme.bodyLarge?.color;
    final borderColor = theme.brightness == Brightness.dark ? Colors.grey[700]! : Colors.grey[300]!;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2555C8) : Colors.transparent, // App Blue
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : borderColor,
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
    );
  }

  Widget _buildImageCard(String imageUrl, {required double height, required bool isDark}) {
    return ClipRRect(
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
    );
  }
}
