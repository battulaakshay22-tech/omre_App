import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/palette.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0C10) : Colors.white,
      appBar: AppBar(
        title: const Text('Learning Streak', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
               Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                 decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFE4C24), Color(0xFFFE8F24)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFE4C24).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.local_fire_department, color: Colors.white, size: 48),
                    ),
                    const SizedBox(height: 24),
                    const Text('12', style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900, height: 1)),
                    const Text('DAY STREAK', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    const SizedBox(height: 24),
                    const Text(
                      'You\'re on fire! 🔥\nKeep learning to maintain your streak.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
               ),
               
               const SizedBox(height: 32),
               
               // Calendar Mock
               Container(
                 padding: const EdgeInsets.all(24),
                 decoration: BoxDecoration(
                   color: isDark ? const Color(0xFF11141B) : Colors.white,
                   borderRadius: BorderRadius.circular(24),
                   border: Border.all(color: Colors.grey.withOpacity(0.1)),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text('January 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                     const SizedBox(height: 24),
                     GridView.builder(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 7,
                         childAspectRatio: 1,
                         mainAxisSpacing: 8,
                         crossAxisSpacing: 8,
                       ),
                       itemCount: 31,
                       itemBuilder: (context, index) {
                         final day = index + 1;
                         // Improve mock logic: Days 10-24 are "streak" days
                         final isStreak = day >= 10 && day <= 24; 
                         final isToday = day == 24;
                         
                         return Container(
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: isStreak ? const Color(0xFFFE4C24) : (isDark ? Colors.grey[800] : Colors.grey[100]),
                             shape: BoxShape.circle,
                              border: isToday ? Border.all(color: Colors.white, width: 2) : null,
                           ),
                           child: Text(
                             '$day', 
                             style: TextStyle(
                               color: isStreak ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[600]),
                               fontWeight: isStreak ? FontWeight.bold : FontWeight.normal,
                             ),
                            ),
                         );
                       },
                     ),
                   ],
                 ),
               ),
               
               const SizedBox(height: 32),
               
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () {
                     // TODO: Navigate to lesson
                     Get.back();
                     Get.snackbar('Lesson Started', 'Good luck!');
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFFFE4C24),
                     foregroundColor: Colors.white,
                     padding: const EdgeInsets.symmetric(vertical: 20),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                   ),
                   child: const Text('Start Today\'s Lesson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
