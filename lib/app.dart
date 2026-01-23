import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routing/router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/state_providers.dart';

class OmreApp extends StatelessWidget {
  const OmreApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Obx(() => GetMaterialApp(
          title: 'OMRE',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: controller.themeMode,
          getPages: AppPages.routes,
          initialRoute: AppPages.initial,
        ));
  }
}
