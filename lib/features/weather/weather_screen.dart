import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Weather', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add_location_alt_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark 
                ? [const Color(0xFF1A237E), const Color(0xFF311B92)] // Deep Blue/Purple
                : [const Color(0xFF4FC3F7), const Color(0xFF2196F3)], // Light Blue
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 24),
          children: [
            const Center(
              child: Text(
                'San Francisco',
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Partly Cloudy',
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                '72°',
                style: TextStyle(color: Colors.white, fontSize: 96, fontWeight: FontWeight.w200),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWeatherStat('Bio', '74°', Icons.thermostat),
                const SizedBox(width: 32),
                _buildWeatherStat('Wind', '12 km/h', Icons.air),
                const SizedBox(width: 32),
                _buildWeatherStat('Humidity', '45%', Icons.water_drop),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              'Forecast',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildForecastCard('Now', '72°', Icons.wb_sunny, true),
                  _buildForecastCard('2 PM', '74°', Icons.wb_sunny, false),
                  _buildForecastCard('4 PM', '71°', Icons.cloud, false),
                  _buildForecastCard('6 PM', '68°', Icons.wb_cloudy, false),
                  _buildForecastCard('8 PM', '64°', Icons.bedtime, false),
                ],
              ),
            ),
             const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('Air Quality', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       SizedBox(height: 4),
                       Text('Good (34 AQI)', style: TextStyle(color: Colors.white70)),
                     ],
                   ),
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                     decoration: BoxDecoration(
                       color: Colors.greenAccent.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(color: Colors.greenAccent),
                     ),
                     child: const Text('SAFE', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                   ),
                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildForecastCard(String time, String temp, IconData icon, bool isCurrent) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: TextStyle(
              color: isCurrent ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            icon,
            color: isCurrent ? Colors.orange : Colors.white,
            size: 28,
          ),
          Text(
            temp,
            style: TextStyle(
              color: isCurrent ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
