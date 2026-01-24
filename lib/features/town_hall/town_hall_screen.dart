import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TownHallScreen extends StatelessWidget {
  const TownHallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Town Hall', style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(theme, isDark),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Discussions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(height: 16),
                  _buildDiscussionCard(
                    'City Infrastructure Plan 2026',
                    'Mayor\'s Office',
                    '1.2K participating',
                    'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?q=80&w=2144&auto=format&fit=crop',
                    isDark,
                    isLive: true,
                  ),
                  _buildDiscussionCard(
                    'School District Budget Review',
                    'Education Board',
                    '450 participating',
                    'https://images.unsplash.com/photo-1577896336183-5248d57d5ab8?q=80&w=2070&auto=format&fit=crop',
                    isDark,
                    isLive: false,
                  ),
                  
                  const SizedBox(height: 24),
                  Text(
                    'Upcoming Votes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(height: 16),
                  _buildVoteCard(
                    'Park Renovation Project',
                    'Ends in 2 days',
                    0.7,
                    isDark,
                  ),
                  _buildVoteCard(
                    'New Library Wing',
                    'Ends in 5 days',
                    0.4,
                    isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      decoration: BoxDecoration(
        color: isDark ? Colors.brown[900] : Colors.orange[50],
      ),
      child: Column(
        children: [
          Icon(Icons.account_balance, size: 48, color: isDark ? Colors.brown[200] : Colors.brown),
          const SizedBox(height: 16),
          Text(
            'Your Civic Voice Matters',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.brown[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Participate in local decisions and govern together.',
            textAlign: TextAlign.center,
            style: TextStyle(color: isDark ? Colors.white70 : Colors.brown[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionCard(String title, String host, String participants, String imageUrl, bool isDark, {bool isLive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isLive)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 8),
                        SizedBox(width: 6),
                        Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hosted by $host',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(participants, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(isLive ? 'Join Now' : 'View Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteCard(String title, String timeLeft, double progress, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Icon(Icons.how_to_vote_outlined, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 4),
          Text(timeLeft, style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.withOpacity(0.1),
              color: Colors.blue,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text('${(progress * 100).toInt()}% Voted', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
