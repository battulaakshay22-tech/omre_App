import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GamesController extends GetxController {
  
  final featuredStream = {
    'title': 'Grand Finals: Neon Vanguard Championship',
    'streamer': 'OfficialOmreEsports',
    'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=2670&auto=format&fit=crop',
    'category': 'Esports',
    'viewers': '45k Viewers',
    'avatar': 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?q=80&w=1780&auto=format&fit=crop',
    'isLive': true
  }.obs;

  final liveChannels = <Map<String, dynamic>>[
    {
      'title': 'Ranked Grind into Masters',
      'streamer': 'KaiCenat • Neon Vanguard',
       'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=2671&auto=format&fit=crop',
      'tags': ['Competitive', '45k'],
    },
    {
      'title': 'Chill Vibes & LoFi',
      'streamer': 'Pokimane • Just Chatting',
      'image': 'https://images.unsplash.com/photo-1552820728-8b83bb6b773f?q=80&w=2670&auto=format&fit=crop',
      'tags': ['Chill', '22k'],
    },
     {
      'title': 'Speedrunning Elden Ring',
      'streamer': 'SpeedRunnerPro • Elden Ring',
      'image': 'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?q=80&w=2670&auto=format&fit=crop',
      'tags': ['Speedrun', '15k'],
    },
  ].obs;

  final trendingClips = <Map<String, dynamic>>[
    {
      'title': 'Incredible Play!',
      'duration': '0:24',
      'creator': 'Ninja',
      'image': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=2670&auto=format&fit=crop',
    },
    {
       'title': 'Funny Moment',
      'duration': '0:45',
      'creator': 'TimTheTatman',
      'image': 'https://images.unsplash.com/photo-1614680376593-902f74cf0d41?q=80&w=2574&auto=format&fit=crop',
    },
    {
       'title': 'Epic Fail',
      'duration': '0:30',
      'creator': 'Shroud',
      'image': 'https://images.unsplash.com/photo-1614680376408-81e91ffe3db7?q=80&w=2574&auto=format&fit=crop',
    },
  ].obs;

  void openStream(String title) {
    Get.snackbar(
      'Opening Stream',
      'Joining $title...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.purple,
      colorText: Colors.white,
      icon: const Icon(Icons.videocam, color: Colors.white),
    );
  }

  void openClip(String title) {
     Get.snackbar(
      'Playing Clip',
      'Now playing $title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
       icon: const Icon(Icons.play_arrow, color: Colors.white),
    );
  }
}
