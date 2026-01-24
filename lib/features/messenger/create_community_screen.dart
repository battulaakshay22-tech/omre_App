import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Tech';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        title: const Text('New Community', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                   CircleAvatar(
                     radius: 50,
                     backgroundColor: Colors.grey.withOpacity(0.1),
                     child: const Icon(Icons.groups_outlined, size: 40, color: Colors.grey),
                   ),
                   Positioned(
                     bottom: 0,
                     right: 0,
                     child: Container(
                       padding: const EdgeInsets.all(8),
                       decoration: const BoxDecoration(color: AppPalette.accentBlue, shape: BoxShape.circle),
                       child: const Icon(Icons.add_a_photo, color: Colors.white, size: 20),
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Community Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'e.g. Flutter Devs India',
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                  items: ['Tech', 'Hobbies', 'News', 'Education', 'Gaming']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is this community about?',
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar('Community Launching', 'Setting up your new community...',
                      backgroundColor: Colors.blueAccent, colorText: Colors.white);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.accentBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Launch Community', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
