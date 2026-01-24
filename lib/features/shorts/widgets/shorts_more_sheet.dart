import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortsMoreSheet extends StatelessWidget {
  const ShortsMoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(77),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          _buildOption(context, Icons.block, 'Not interested', textColor),
          _buildOption(context, Icons.person_off_outlined, "Don't recommend channel", textColor),
          _buildOption(context, Icons.report_gmailerrorred, 'Report content', Colors.red),
          _buildOption(context, Icons.playlist_add, 'Save to playlist', textColor),
          _buildOption(context, Icons.download_outlined, 'Download to device', textColor),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String label, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      onTap: () {
        Get.back();
        Get.snackbar(
          'Updated',
          'Feedback received: $label',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withAlpha(25),
          colorText: Colors.blue,
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
