import 'package:omre/core/constants/app_assets.dart';
import 'package:get/get.dart';


import 'package:flutter/material.dart';
import '../live_channel_screen.dart';
import '../trending_clip_screen.dart';

class GamesController extends GetxController {
  
  final featuredStream = {
    'title': 'Grand Finals: Neon Vanguard Championship',
    'streamer': 'OfficialOmreEsports',
      'image': AppAssets.getRandomPost(),
      'name': 'Elden Ring',
      'views': '296k',
      'avatar': AppAssets.getRandomAvatar(),
    'isLive': true
  }.obs;

  final liveChannels = <Map<String, dynamic>>[
    {
      'title': 'Ranked Grind into Masters',
      'streamer': 'KaiCenat • Neon Vanguard',
       'image': AppAssets.post1,
      'avatar': AppAssets.avatar1,
      'tags': ['Competitive', '45k'],
    },
    {
      'title': 'Chill Vibes & LoFi',
      'streamer': 'Pokimane • Just Chatting',
      'image': AppAssets.post2,
      'avatar': AppAssets.avatar2,
      'tags': ['Chill', '22k'],
    },
     {
      'title': 'Speedrunning Elden Ring',
      'streamer': 'SpeedRunnerPro • Elden Ring',
      'image': AppAssets.post3,
      'avatar': AppAssets.avatar3,
      'tags': ['Speedrun', '15k'],
    },
  ].obs;

  final trendingClips = <Map<String, dynamic>>[
    {
      'title': 'Incredible Play!',
      'duration': '0:24',
      'creator': 'Ninja',
      'image': AppAssets.thumbnail1,
    },
    {
       'title': 'Funny Moment',
      'duration': '0:45',
      'creator': 'TimTheTatman',
      'image': AppAssets.thumbnail2,
    },
    {
       'title': 'Epic Fail',
      'duration': '0:30',
      'creator': 'Shroud',
      'image': AppAssets.thumbnail3,
    },
  ].obs;

  void openStream(Map<String, dynamic> channel) {
    Get.to(() => LiveChannelScreen(channel: channel));
  }

  void openClip(Map<String, dynamic> clip) {
    Get.to(() => TrendingClipScreen(clip: clip));
  }
}

