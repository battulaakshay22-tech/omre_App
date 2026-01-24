import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../shorts/widgets/shorts_comments_sheet.dart';
import '../shorts/widgets/shorts_share_sheet.dart';
import '../shorts/widgets/shorts_more_sheet.dart';

class TrendingClipScreen extends StatefulWidget {
  final Map<String, dynamic> clip;

  const TrendingClipScreen({super.key, required this.clip});

  @override
  State<TrendingClipScreen> createState() => _TrendingClipScreenState();
}

class _TrendingClipScreenState extends State<TrendingClipScreen> {
  late VideoPlayerController _controller;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Player
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(color: Colors.orange),
          ),

          // Back Button
          Positioned(
            top: 48,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),

          // Right Side Actions
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                _buildAction(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  label: '24K',
                  color: _isLiked ? Colors.red : Colors.white,
                  onTap: () => setState(() => _isLiked = !_isLiked),
                ),
                _buildAction(
                  icon: Icons.comment,
                  label: '1.2K',
                  onTap: () {
                    Get.bottomSheet(
                      const ShortsCommentsSheet(),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                ),
                _buildAction(
                  icon: Icons.share,
                  label: 'Share',
                  onTap: () {
                    Get.bottomSheet(
                      const ShortsShareSheet(),
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
                _buildAction(
                  icon: Icons.more_vert,
                  label: '',
                  onTap: () {
                    Get.bottomSheet(
                      const ShortsMoreSheet(),
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
              ],
            ),
          ),

          // Bottom Info
          Positioned(
            left: 16,
            bottom: 40,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 16, backgroundColor: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      widget.clip['creator'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.clip['title'],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.music_note, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    const Text('Original Sound - Gaming Mix', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction({required IconData icon, required String label, Color color = Colors.white, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
