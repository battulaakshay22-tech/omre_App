
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Mock Video Content (Image as placeholder)
              Image.network(
                'https://picsum.photos/seed/short${index + 1}/1080/1920',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[900]),
              ),
              
              // Gradient Overlay
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
              ),

              // Back Button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  onPressed: () => Get.back(),
                ),
              ),

              // Side Actions
              Positioned(
                right: 16,
                bottom: 120,
                child: Column(
                  children: [
                    _buildActionItem(Icons.favorite, '12.4k', Colors.red),
                    const SizedBox(height: 20),
                    _buildActionItem(Icons.chat_bubble, '852', Colors.white),
                    const SizedBox(height: 20),
                    _buildActionItem(Icons.share, '1.2k', Colors.white),
                    const SizedBox(height: 20),
                    _buildActionItem(Icons.more_horiz, '', Colors.white),
                  ],
                ),
              ),

              // Bottom Info
              Positioned(
                left: 16,
                right: 80,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=user'),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          '@omre_creator',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppPalette.accentBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Designing the future of social apps with OMRE! 🚀✨ #ux #ui #flutter #shorts #creative',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
