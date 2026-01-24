import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Channel Analytics',
            style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: const Color(0xFF3B82F6),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF3B82F6),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Content'),
              Tab(text: 'Audience'),
              Tab(text: 'Revenue'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(theme, isDark),
            _buildPlaceholderTab('Content Analytics'),
            _buildPlaceholderTab('Audience Insights'),
            _buildPlaceholderTab('Revenue Details'),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(ThemeData theme, bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildMetricSummary(theme, isDark),
        const SizedBox(height: 24),
        _buildSectionHeader('Channel Growth', theme),
        const SizedBox(height: 16),
        _buildMockChart(isDark),
        const SizedBox(height: 24),
        _buildSectionHeader('Top Videos', theme),
        const SizedBox(height: 16),
        _buildTopVideoItem('How to build a Flutter App', '45.2K views', theme),
        _buildTopVideoItem('State Management Explained', '32.1K views', theme),
        _buildTopVideoItem('GetX vs Provider in 2026', '28.5K views', theme),
      ],
    );
  }

  Widget _buildMetricSummary(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Your channel got 892,400 views in the last 28 days',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSmallMetric('Views', '892K', '+12%', true),
              _buildSmallMetric('Watch Time', '24K', '+8%', true),
              _buildSmallMetric('Subscribers', '+1.2K', '+5%', true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallMetric(String label, String value, String change, bool isPositive) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          change,
          style: TextStyle(fontSize: 11, color: isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMockChart(bool isDark) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 48, color: Colors.blue.withOpacity(0.5)),
            const SizedBox(height: 8),
            const Text('Performance Chart', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
    );
  }

  Widget _buildTopVideoItem(String title, String views, ThemeData theme) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 80,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.play_circle_outline, color: Colors.grey),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(views, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
    );
  }

  Widget _buildPlaceholderTab(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.analytics_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
