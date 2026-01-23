import 'package:flutter/material.dart';
import '../../core/theme/palette.dart';

class LinkHomeScreen extends StatefulWidget {
  const LinkHomeScreen({super.key});

  @override
  State<LinkHomeScreen> createState() => _LinkHomeScreenState();
}

class _LinkHomeScreenState extends State<LinkHomeScreen> {
  bool isJobsSelected = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header / Tabs
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              color: isDark ? Colors.grey[900] : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   _buildTabButton('Jobs', isJobsSelected, () {
                     setState(() {
                       isJobsSelected = true;
                     });
                   }, isDark),
                   const SizedBox(width: 16),
                   _buildTabButton('Marketplace', !isJobsSelected, () {
                     setState(() {
                       isJobsSelected = false;
                     });
                   }, isDark),
                ],
              ),
            ),
            
            // Hero Section containing gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark 
                    ? [Colors.grey[900]!, Colors.black]
                    : [const Color(0xFFF0F4FF), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF4F46E5).withOpacity(0.2) : const Color(0xFFE0E7FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: Color(0xFF4F46E5)),
                        const SizedBox(width: 8),
                        Text(
                          'Over 16 new opportunities today',
                          style: TextStyle(
                            color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4F46E5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 36, 
                          fontWeight: FontWeight.w900, 
                          color: isDark ? Colors.white : Colors.black,
                          height: 1.2,
                          fontFamily: '.SF Pro Display', // System font fallback
                        ),
                        children: const [
                          TextSpan(text: 'Find your next\n'),
                          TextSpan(
                            text: 'dream job',
                            style: TextStyle(color: Color(0xFF4F46E5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Discover thousands of remote & on-site opportunities at top tech companies, startups, and agencies.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[100]!),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                            decoration: InputDecoration(
                              hintText: 'Job title, keywords, or company',
                              hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                              prefixIcon: Icon(Icons.search, color: isDark ? Colors.grey[500] : Colors.grey[400]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                          Divider(height: 1, color: isDark ? Colors.grey[700] : Colors.grey[200]),
                          TextField(
                            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                            decoration: InputDecoration(
                              hintText: 'City, state, or remote',
                              hintStyle: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
                              prefixIcon: Icon(Icons.location_on_outlined, color: isDark ? Colors.grey[500] : Colors.grey[400]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2555C8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Search Jobs',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  
                  // Trending
                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          'Trending:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2555C8),
                          ),
                        ),
                        const SizedBox(width: 8),
                         _buildTag('Remote', isDark),
                         _buildTag('Frontend', isDark),
                         _buildTag('Design', isDark),
                         _buildTag('Marketing', isDark),
                         _buildTag('Product Manager', isDark),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
            
            // Job Cards Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildJobCard(
                        color: Colors.blue[50]!, 
                        salary: '\$40hr', 
                        title: 'Product Designer',
                        isDark: isDark,
                        iconColor: Colors.blue,
                      ),
                      const SizedBox(width: 16),
                      _buildJobCard(
                        color: Colors.purple[50]!, 
                        salary: '\$120k', 
                        title: 'Senior Dev',
                        isDark: isDark,
                        iconColor: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildJobCard(
                        color: Colors.green[50]!, 
                        salary: '\$50hr', 
                        title: 'Marketing Head',
                        isDark: isDark,
                        iconColor: Colors.green,
                      ),
                       const SizedBox(width: 16),
                      _buildJobCard(
                        color: Colors.orange[50]!, 
                        salary: '\$180k', 
                        title: 'CTO',
                        isDark: isDark,
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
            ? (isDark ? Colors.grey[800] : Colors.white) 
            : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [
             BoxShadow(
               color: Colors.black.withOpacity(0.05),
               blurRadius: 4,
               offset: const Offset(0, 2),
             )
          ] : [],
        ),
        child: Row(
          children: [
             Icon(
               label == 'Jobs' ? Icons.work_outline : Icons.shopping_cart_outlined,
               size: 18,
               color: isSelected 
                 ? (isDark ? Colors.white : Colors.black) 
                 : (isDark ? Colors.grey[400] : Colors.grey),
             ),
             const SizedBox(width: 8),
             Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected 
                 ? (isDark ? Colors.white : Colors.black) 
                 : (isDark ? Colors.grey[400] : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTag(String label, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey[300] : Colors.grey[800],
        ),
      ),
    );
  }
  
  Widget _buildJobCard({
    required Color color, 
    required String salary, 
    required String title, 
    required bool isDark,
    required Color iconColor,
  }) {
    return Expanded(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[100]!),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(isDark ? 0.1 : 0.02),
               blurRadius: 10,
               offset: const Offset(0, 4),
             )
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isDark ? iconColor.withOpacity(0.2) : color,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const Spacer(),
            Text(
              salary,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
