import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class WriteScriptScreen extends StatefulWidget {
  const WriteScriptScreen({super.key});

  @override
  State<WriteScriptScreen> createState() => _WriteScriptScreenState();
}

class _WriteScriptScreenState extends State<WriteScriptScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _scriptController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _scriptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text('New Script', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
               Get.back();
               Get.snackbar('Saved', 'Script draft saved successfully.', snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text('Save Draft', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              decoration: const InputDecoration(
                hintText: 'Video Title',
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            Expanded(
              child: TextField(
                controller: _scriptController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 16, height: 1.5, color: theme.textTheme.bodyLarge?.color),
                decoration: const InputDecoration(
                  hintText: 'Start writing your script here...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
