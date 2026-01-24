import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';
import 'controllers/education_controller.dart';

class WeeklyGoalScreen extends StatelessWidget {
  const WeeklyGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EducationController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C10) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Weekly Goal',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Header
            _buildProgressCard(controller, isDark),
            const SizedBox(height: 32),
            
            // Daily Chart
            _buildSectionHeader('Weekly Activity'),
            const SizedBox(height: 16),
            _buildWeeklyChart(controller, isDark),
            const SizedBox(height: 32),
            
            // Goal Settings
            _buildSectionHeader('Goal Settings'),
            const SizedBox(height: 16),
            Obx(() => _buildGoalSettingItem(
              icon: Icons.flag_outlined,
              title: 'Weekly Lesson Target',
              subtitle: 'Current: ${controller.weeklyLessonTarget} lessons per week',
              onTap: () => _showTargetDialog(context, controller),
              isDark: isDark,
            )),
            Obx(() => _buildGoalSettingItem(
              icon: Icons.notifications_none,
              title: 'Study Reminders',
              subtitle: 'Daily at ${controller.studyReminderTime}',
              onTap: () => _showTimePickerDialog(context, controller),
              isDark: isDark,
            )),
            Obx(() => _buildGoalSettingItem(
              icon: Icons.trending_up,
              title: 'Difficulty Level',
              subtitle: 'Current: ${controller.difficultyLevel}',
              onTap: () => _showDifficultyDialog(context, controller),
              isDark: isDark,
            )),
            
            const SizedBox(height: 40),
            
            // Tips Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppPalette.accentBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppPalette.accentBlue.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Text('💡', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pro Tip for Success',
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppPalette.accentBlue),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Learners who study at the same time every day are 75% more likely to reach their goals!',
                          style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildProgressCard(EducationController controller, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Obx(() => CircularProgressIndicator(
                  value: controller.weeklyProgress.value,
                  strokeWidth: 12,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                )),
              ),
              Column(
                children: [
                  Obx(() => Text(
                    '${(controller.weeklyProgress.value * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
                  const Text(
                    'Done',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Keep going, Alex!',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'You have 2 lessons left to reach your weekly goal.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(EducationController controller, bool isDark) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final progress = [0.8, 0.6, 0.9, 0.4, 0.0, 0.0, 0.0];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF11141B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          return Column(
            children: [
              Container(
                height: 120 * progress[index],
                width: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      progress[index] > 0 
                        ? (index == 3 ? AppPalette.accentBlue : const Color(0xFF6366F1))
                        : Colors.grey.withOpacity(0.1),
                      progress[index] > 0 
                        ? (index == 3 ? AppPalette.accentBlue.withOpacity(0.8) : const Color(0xFF8B5CF6))
                        : Colors.grey.withOpacity(0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: progress[index] >= 0.8 
                  ? const Center(child: Icon(Icons.star, color: Colors.white, size: 16))
                  : null,
              ),
              const SizedBox(height: 12),
              Text(
                days[index],
                style: TextStyle(
                  color: index == 3 ? AppPalette.accentBlue : Colors.grey,
                  fontWeight: index == 3 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildGoalSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF11141B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppPalette.accentBlue, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      ),
    );
  }

  void _showTargetDialog(BuildContext context, EducationController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Weekly Lesson Target'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [3, 5, 7, 10, 14].map((target) => ListTile(
            title: Text('$target lessons'),
            onTap: () {
              controller.weeklyLessonTarget.value = target;
              Get.back();
              Get.snackbar('Target Updated', 'Your weekly goal is now $target lessons.', snackPosition: SnackPosition.BOTTOM);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showTimePickerDialog(BuildContext context, EducationController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 20, minute: 0),
    );
    if (picked != null) {
      controller.studyReminderTime.value = picked.format(context);
      Get.snackbar('Reminder Set', 'We will remind you daily at ${picked.format(context)}.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _showDifficultyDialog(BuildContext context, EducationController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Difficulty Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Beginner', 'Intermediate', 'Advanced', 'Expert'].map((level) => ListTile(
            title: Text(level),
            onTap: () {
              controller.difficultyLevel.value = level;
              Get.back();
              Get.snackbar('Level Updated', 'Current difficulty set to $level.', snackPosition: SnackPosition.BOTTOM);
            },
          )).toList(),
        ),
      ),
    );
  }
}
