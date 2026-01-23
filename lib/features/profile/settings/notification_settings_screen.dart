import 'package:flutter/material.dart';
import '../../../core/theme/palette.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildToggle('Pause All', false),
          const Divider(),
          _buildSection('Posts, Stories and Comments'),
          _buildToggle('Likes', true),
          _buildToggle('Comments', true),
          _buildToggle('Photos of You', true),
          _buildSection('Following and Followers'),
          _buildToggle('New Followers', true),
          _buildToggle('Accepted Follow Requests', false),
          _buildSection('Messages'),
          _buildToggle('Message Requests', true),
          _buildToggle('Group Requests', true),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildToggle(String title, bool value) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (val) {},
        activeThumbColor: AppPalette.accentBlue,
      ),
    );
  }
}
