import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/add_story_controller.dart';
import '../../core/theme/palette.dart';

class AddStoryScreen extends GetView<AddStoryController> {
  const AddStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () => controller.uploadStory(),
            child: Obx(() => controller.isUploading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppPalette.accentBlue),
                  )
                : const Text(
                    'Post',
                    style: TextStyle(color: AppPalette.accentBlue, fontWeight: FontWeight.bold, fontSize: 16),
                  )),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.selectedMedia.value != null) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      controller.selectedMedia.value!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: TextField(
                        onChanged: (val) => controller.caption.value = val,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: const InputDecoration(
                          hintText: 'Add a caption...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          fillColor: Colors.black45,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_photo_alternate_outlined, color: Colors.white54, size: 80),
                      const SizedBox(height: 20),
                      const Text(
                        'Add to your story',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionButton(
                            icon: Icons.camera_alt,
                            label: 'Camera',
                            onTap: () => controller.pickImage(ImageSource.camera),
                          ),
                          const SizedBox(width: 30),
                          _buildOptionButton(
                            icon: Icons.photo_library,
                            label: 'Gallery',
                            onTap: () => controller.pickImage(ImageSource.gallery),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
