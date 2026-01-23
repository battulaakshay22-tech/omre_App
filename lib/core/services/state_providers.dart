import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppMode { social, messenger, education, biz, link, studio, news, video, orbit, games, meeting }

class AppController extends GetxController {
  final _appMode = AppMode.social.obs;
  AppMode get appMode => _appMode.value;
  set appMode(AppMode value) => _appMode.value = value;

  final _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;
  set themeMode(ThemeMode value) => _themeMode.value = value;

  final _bottomNavIndex = 0.obs;
  int get bottomNavIndex => _bottomNavIndex.value;
  set bottomNavIndex(int value) => _bottomNavIndex.value = value;

  final isSearching = false.obs;
  final searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
