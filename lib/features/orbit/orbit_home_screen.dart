import 'package:flutter/material.dart';

class OrbitHomeScreen extends StatefulWidget {
  const OrbitHomeScreen({super.key});

  @override
  State<OrbitHomeScreen> createState() => _OrbitHomeScreenState();
}

class _OrbitHomeScreenState extends State<OrbitHomeScreen> {
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _topics = [
    {
      'category': 'Tech',
      'status': 'Trending',
      'title': 'AI Ethics & Safety',
      'desc': 'Debating alignment, regulation, and the future of AGI.',
      'live': '1,420 live',
      'langs': ['EN', 'ES'],
      'isVerified': true,
    },
    {
      'category': 'Global',
      'status': 'Active',
      'title': 'Global Climate Action',
      'desc': 'Real-time updates on renewable energy and international policy.',
      'live': '856 live',
      'langs': ['EN', 'FR', 'DE'],
      'isVerified': true,
    },
    {
      'category': 'Science',
      'status': 'Active',
      'title': 'Mars Colonization',
      'desc': 'Feasibility, timelines, and Starship updates.',
      'live': '342 live',
      'langs': ['EN'],
      'isVerified': false,
    },
    {
      'category': 'Finance',
      'status': 'Trending',
      'title': '2026 Market Outlook',
      'desc': 'Macro trends, crypto, and traditional finance analysis.',
      'live': '2,100 live',
      'langs': ['EN', 'ZH'],
      'isVerified': true,
    },
    {
      'category': 'Arts',
      'status': 'Quiet',
      'title': 'Modern Architecture',
      'desc': 'Discussing brutalism, sustainability, and urban design.',
      'live': '120 live',
      'langs': ['EN'],
      'isVerified': false,
    },
    {
      'category': 'Sports',
      'status': 'Trending',
      'title': 'Premier League Tactics',
      'desc': 'Match analysis, formations, and transfer rumors.',
      'live': '3,200 live',
      'langs': ['EN'],
      'isVerified': false,
    },
  ];

  void _showAddTopicSheet() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = 'Tech';
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F0F0F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            top: 32,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create New Topic',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Topic Title', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'e.g. Future of Quantum Computing',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Category', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    dropdownColor: const Color(0xFF1A1A1A),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    isExpanded: true,
                    items: ['Tech', 'Science', 'Politics', 'Sports', 'Arts', 'Global']
                        .map((cat) => DropdownMenuItem(value: cat, child: Text(cat, style: const TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (val) => setModalState(() => selectedCategory = val!),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Description', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: descController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'What will people talk about in this room?',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      setState(() {
                        _topics.insert(0, {
                          'category': selectedCategory,
                          'status': 'Active',
                          'title': titleController.text,
                          'desc': descController.text,
                          'live': '1 live',
                          'langs': ['EN'],
                          'isVerified': false,
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Topic "${titleController.text}" created successfully!'),
                          backgroundColor: const Color(0xFF2563EB),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Launch Topic', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Advanced Filters',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text('Language', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['English', 'Spanish', 'French', 'Chinese', 'German'].map((lang) {
                return Chip(
                  label: Text(lang),
                  backgroundColor: Colors.white.withOpacity(0.05),
                  labelStyle: const TextStyle(color: Colors.white70),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Verified Topics Only', style: TextStyle(color: Colors.white70, fontSize: 14)),
                Switch(
                  value: false, 
                  onChanged: (val) {},
                  activeColor: const Color(0xFF2563EB),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Minimum Listeners', style: TextStyle(color: Colors.white70, fontSize: 14)),
            Slider(
              value: 100,
              min: 0,
              max: 1000,
              divisions: 10,
              label: '100',
              activeColor: const Color(0xFF2563EB),
              onChanged: (val) {},
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filters applied')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTopicSheet,
        backgroundColor: const Color(0xFF2563EB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroSection(controller: _searchController),
              _TopicFilters(
                selectedFilter: selectedFilter,
                onFilterChanged: (filter) {
                  setState(() => selectedFilter = filter);
                },
                onAdvancedTap: _showAdvancedFilters,
              ),
              _TopicGrid(
                selectedFilter: selectedFilter,
                topics: _topics,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final TextEditingController controller;
  const _HeroSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Find your signal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Join real-time, structured conversations\norganized by topic, not clout.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search topics, not people...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.3)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicFilters extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final VoidCallback onAdvancedTap;

  const _TopicFilters({
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onAdvancedTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> filters = [
      'All', 'Trending', 'Tech', 'Science', 'Politics', 'Sports', 'Arts', 'Global'
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              const Icon(Icons.bolt, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Explore Topics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onAdvancedTap,
                child: Row(
                  children: [
                    Icon(Icons.filter_list, color: Colors.white.withValues(alpha: 0.5), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Advanced',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final isSelected = selectedFilter == filters[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => onFilterChanged(filters[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      filters[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
        ),
      ],
    );
  }
}

class _TopicGrid extends StatelessWidget {
  final String selectedFilter;
  final List<Map<String, dynamic>> topics;
  const _TopicGrid({required this.selectedFilter, required this.topics});

  @override
  Widget build(BuildContext context) {
    final filteredTopics = topics.where((topic) {
      if (selectedFilter == 'All') return true;
      if (selectedFilter == 'Trending') return topic['status'] == 'Trending';
      return topic['category'] == selectedFilter;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: filteredTopics.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(Icons.search_off, color: Colors.white.withValues(alpha: 0.2), size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'No topics for "$selectedFilter" yet',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.6,
              ),
              itemCount: filteredTopics.length,
              itemBuilder: (context, index) => _TopicCard(topic: filteredTopics[index]),
            ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Map<String, dynamic> topic;
  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    final status = topic['status'] as String;
    Color statusColor;
    IconData statusIcon;

    if (status == 'Trending') {
      statusColor = const Color(0xFFFE5722);
      statusIcon = Icons.local_fire_department;
    } else if (status == 'Active') {
      statusColor = const Color(0xFF10B981);
      statusIcon = Icons.show_chart;
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.nightlight_round;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  topic['category'] as String,
                  style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  topic['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (topic['isVerified'] as bool)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.shield, color: Colors.blue, size: 18),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            topic['desc'] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13, height: 1.4),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.people_outline, color: Colors.white.withValues(alpha: 0.3), size: 16),
              const SizedBox(width: 8),
              Text(
                topic['live'] as String,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 12),
              ),
              const Spacer(),
              Row(
                children: (topic['langs'] as List<String>).map((lang) {
                  return Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      lang,
                      style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
