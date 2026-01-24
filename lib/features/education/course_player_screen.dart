import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursePlayerScreen extends StatelessWidget {
  const CoursePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Video Player Placeholder',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
