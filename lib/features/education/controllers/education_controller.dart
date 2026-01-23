import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CourseCategory {
  final String name;
  final int count;
  final IconData icon;
  final Color color;

  CourseCategory({
    required this.name,
    required this.count,
    required this.icon,
    required this.color,
  });
}

class CourseModel {
  final String title;
  final String instructor;
  final int students;
  final String duration;
  final double price;
  final double rating;
  final String thumbnailUrl;

  CourseModel({
    required this.title,
    required this.instructor,
    required this.students,
    required this.duration,
    required this.price,
    required this.rating,
    required this.thumbnailUrl,
  });
}

class EducationController extends GetxController {
  final categories = <CourseCategory>[
    CourseCategory(name: 'Development', count: 2450, icon: Icons.code, color: Colors.blue),
    CourseCategory(name: 'Design', count: 1230, icon: Icons.palette, color: Colors.pink),
    CourseCategory(name: 'Business', count: 980, icon: Icons.bar_chart, color: Colors.orange),
    CourseCategory(name: 'Photography', count: 650, icon: Icons.camera_alt, color: Colors.green),
  ].obs;

  final recommendedCourses = <CourseModel>[
    CourseModel(
      title: 'Complete Development Bootcamp 2026',
      instructor: 'Jose Portilla',
      students: 1000,
      duration: '10h 0m',
      price: 19.99,
      rating: 4.8,
      thumbnailUrl: 'https://picsum.photos/seed/code/400/300',
    ),
    CourseModel(
      title: 'Advanced Flutter Mastery',
      instructor: 'Maximilian Schwarzmüller',
      students: 1500,
      duration: '15h 30m',
      price: 24.99,
      rating: 4.9,
      thumbnailUrl: 'https://picsum.photos/seed/flutter/400/300',
    ),
  ].obs;

  final learningStreak = 12.obs;
  final weeklyProgress = 0.6.obs; // 3 of 5 lessons
  final certificatesEarned = 8.obs;
}
