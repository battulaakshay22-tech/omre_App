import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera Preview Placeholder
          Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.camera_alt, size: 100, color: Colors.white24),
            ),
          ),
          
          // Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.flash_off, color: Colors.white, size: 28)
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.snackbar('Photo Captured', 'Image sent to chat', 
                      snackPosition: SnackPosition.BOTTOM, 
                      backgroundColor: Colors.white,
                      colorText: Colors.black,
                    );
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 28)
                ),
              ],
            ),
          ),

          // Header
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
