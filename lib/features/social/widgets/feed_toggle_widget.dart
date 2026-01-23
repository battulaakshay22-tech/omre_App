import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/palette.dart';

import '../controllers/home_controller.dart';

class FeedToggleWidget extends GetView<HomeController> {
  const FeedToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12, width: 0.5)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Obx(() => _TabButton(
                label: 'Following',
                isSelected: controller.currentFeedIndex.value == 0,
                onTap: () => controller.currentFeedIndex.value = 0,
              )),
            ),
            SizedBox(
              width: 100,
              child: Obx(() => _TabButton(
                label: 'For You',
                isSelected: controller.currentFeedIndex.value == 1,
                onTap: () => controller.currentFeedIndex.value = 1,
              )),
            ),
            SizedBox(
              width: 100,
              child: Obx(() => _TabButton(
                label: 'Trending',
                isSelected: controller.currentFeedIndex.value == 2,
                onTap: () => controller.currentFeedIndex.value = 2,
              )),
            ),
            SizedBox(
              width: 100,
              child: Obx(() => _TabButton(
                label: 'Latest',
                isSelected: controller.currentFeedIndex.value == 3,
                onTap: () => controller.currentFeedIndex.value = 3,
              )),
            ),
            SizedBox(
              width: 100,
              child: Obx(() => _TabButton(
                label: 'Near You',
                isSelected: controller.currentFeedIndex.value == 4,
                onTap: () => controller.currentFeedIndex.value = 4,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        child: Column(
          children: [
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected 
                    ? (isDark ? Colors.white : Colors.black) 
                    : Colors.grey,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                  color: AppPalette.accentBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            if (!isSelected) const SizedBox(height: 3), // Layout placeholder
          ],
        ),
      ),
    );
  }
}
