import 'package:flutter/material.dart';
import '../../../core/theme/palette.dart';

class DataUsageScreen extends StatelessWidget {
  const DataUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Usage', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSection('Mobile Data', [
            _buildToggle('Use Less Mobile Data', true, 'Lower resolution for videos and images when on cellular.'),
            _buildToggle('High-Quality Uploads', false, 'Always upload photos and videos in highest quality.'),
          ]),
          _buildSection('Media Auto-Download', [
            _buildTile('Photos', 'Wi-Fi and Cellular'),
            _buildTile('Audio', 'Wi-Fi only'),
            _buildTile('Videos', 'Wi-Fi only'),
            _buildTile('Documents', 'Wi-Fi only'),
          ]),
          _buildSection('Video Autoplay', [
            _buildTile('Autoplay', 'On Wi-Fi only'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppPalette.accentBlue)),
        ),
        ...children,
      ],
    );
  }

  Widget _buildToggle(String title, bool value, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: Switch(
        value: value,
        onChanged: (val) {},
        activeThumbColor: AppPalette.accentBlue,
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
      onTap: () {},
    );
  }
}
