import 'package:flutter/material.dart';
import '../presentation/talent_discovery_feed/talent_discovery_feed.dart';
import '../presentation/athlete_profile/athlete_profile.dart';
import '../presentation/scout_network_and_connections/scout_network_and_connections.dart';
import '../presentation/ai_performance_analytics_dashboard/ai_performance_analytics_dashboard.dart';
import '../presentation/video_upload_and_analysis/video_upload_and_analysis.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String talentDiscoveryFeed = '/talent-discovery-feed';
  static const String athleteProfile = '/athlete-profile';
  static const String scoutNetworkAndConnections =
      '/scout-network-and-connections';
  static const String aiPerformanceAnalyticsDashboard =
      '/ai-performance-analytics-dashboard';
  static const String videoUploadAndAnalysis = '/video-upload-and-analysis';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const TalentDiscoveryFeed(),
    talentDiscoveryFeed: (context) => const TalentDiscoveryFeed(),
    athleteProfile: (context) => const AthleteProfile(),
    scoutNetworkAndConnections: (context) => const ScoutNetworkAndConnections(),
    aiPerformanceAnalyticsDashboard: (context) =>
        const AiPerformanceAnalyticsDashboard(),
    videoUploadAndAnalysis: (context) => const VideoUploadAndAnalysis(),
    // TODO: Add your other routes here
  };
}
