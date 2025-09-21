import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sportifyai_app/core/app_export.dart'; // Assuming AppTheme is here

// TODO: Create and import your custom widgets.
// For now, this code uses standard Flutter widgets as placeholders.
// import '../ai_performance_analytics_dashboard/widgets/performance_metric_card.dart';
// import '../ai_performance_analytics_dashboard/widgets/performance_chart_widget.dart';
// import '../video_upload_and_analysis/widgets/video_review_widget.dart';
// import 'widgets/achievement_badge_widget.dart';

class AthleteProfile extends StatefulWidget {
  const AthleteProfile({Key? key}) : super(key: key);

  @override
  State<AthleteProfile> createState() => _AthleteProfileState();
}

class _AthleteProfileState extends State<AthleteProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isHeaderCollapsed = false;

  // Mock athlete data (remains the same)
  final Map<String, dynamic> athleteData = {
    "id": 1, "name": "Marcus Johnson", "sport": "Basketball", "position": "Point Guard", "age": 19, "location": "Chicago, IL", "verified": true, "profileImage": "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg", "coverImage": "https://images.pexels.com/photos/1752757/pexels-photo-1752757.jpeg", "bio": "Passionate basketball player with 8+ years of experience. Led high school team to state championship. Seeking opportunities to play at collegiate level.", "stats": {"height": "6'2\"", "weight": "185 lbs", "experience": "8 years", "gamesPlayed": 127, "averagePoints": 18.5, "assists": 8.2, "rebounds": 5.1}
  };
  final List<Map<String, dynamic>> achievements = [
    {"id": 1, "type": "medal", "title": "State Champion", "icon": "emoji_events", "unlocked": true,}, {"id": 2, "type": "badge", "title": "MVP", "icon": "star", "unlocked": true,}, {"id": 3, "type": "badge", "title": "Team Captain", "icon": "military_tech", "unlocked": true,}, {"id": 4, "type": "medal", "title": "Regional Winner", "icon": "workspace_premium", "unlocked": true,}, {"id": 5, "type": "badge", "title": "Rising Star", "icon": "trending_up", "unlocked": false,}
  ];
  final List<Map<String, dynamic>> performanceMetrics = [
    {"title": "Points Per Game", "value": "18.5", "unit": "pts", "progress": 0.85, "trend": "up", "icon": "sports_basketball",}, {"title": "Assists", "value": "8.2", "unit": "avg", "progress": 0.92, "trend": "up", "icon": "group_work",}, {"title": "Field Goal %", "value": "47.3", "unit": "%", "progress": 0.73, "trend": "stable", "icon": "gps_fixed",}, {"title": "Free Throws", "value": "82.1", "unit": "%", "progress": 0.82, "trend": "up", "icon": "sports_score",}
  ];
  final List<Map<String, dynamic>> videoHighlights = [
    {"id": 1, "title": "State Championship Game Highlights", "thumbnail": "https://images.pexels.com/photos/1752757/pexels-photo-1752757.jpeg", "duration": "3:45", "views": 1247, "uploadDate": "2024-03-15",}, {"id": 2, "title": "Triple-Double Performance vs Eagles", "thumbnail": "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg", "duration": "2:18", "views": 892, "uploadDate": "2024-03-10",}, {"id": 3, "title": "Clutch Shot in Regional Finals", "thumbnail": "https://images.pexels.com/photos/1752757/pexels-photo-1752757.jpeg", "duration": "1:32", "views": 2156, "uploadDate": "2024-03-05",}, {"id": 4, "title": "Season Best: 28 Points vs Warriors", "thumbnail": "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg", "duration": "4:12", "views": 1543, "uploadDate": "2024-02-28",}
  ];
  final List<Map<String, dynamic>> achievementTimeline = [
    {"title": "State Championship Victory", "description": "Led team to state championship with 24 points and 10 assists in the final game", "date": "March 15, 2024", "type": "medal", "icon": "emoji_events",}, {"title": "Regional MVP Award", "description": "Named Most Valuable Player for outstanding performance throughout regional tournament", "date": "March 8, 2024", "type": "achievement", "icon": "star",}, {"title": "Team Captain Appointment", "description": "Selected as team captain by coaches and teammates for leadership qualities", "date": "September 1, 2023", "type": "milestone", "icon": "military_tech",}, {"title": "1000 Career Points", "description": "Reached career milestone of 1000 points scored in high school basketball", "date": "January 20, 2024", "type": "milestone", "icon": "sports_basketball",}
  ];
  final List<Map<String, dynamic>> performanceChartData = [
    {"label": "Sep", "value": 15.2}, {"label": "Oct", "value": 16.8}, {"label": "Nov", "value": 17.5}, {"label": "Dec", "value": 18.1}, {"label": "Jan", "value": 19.3}, {"label": "Feb", "value": 18.9}, {"label": "Mar", "value": 20.1}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bool isCollapsed = _scrollController.hasClients && _scrollController.offset > 20.h;
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() {
        _isHeaderCollapsed = isCollapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildSliverAppBar(),
            _buildSliverTabBar(),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(),
            _buildVideosTab(),
            _buildAnalyticsTab(),
            _buildAchievementsTab(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 35.h,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.backgroundLight,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon( // Replaced CustomIconWidget
          Icons.arrow_back,
          color: _isHeaderCollapsed ? AppTheme.textHighEmphasisLight : Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon( // Replaced CustomIconWidget
            Icons.share,
            color: _isHeaderCollapsed ? AppTheme.textHighEmphasisLight : Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon( // Replaced CustomIconWidget
            Icons.more_vert,
            color: _isHeaderCollapsed ? AppTheme.textHighEmphasisLight : Colors.white,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network( // Replaced CustomImageWidget
              athleteData['coverImage'] as String,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : const Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 8.h,
              left: 4.w,
              right: 4.w,
              child: _buildProfileHeader(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(color: AppTheme.shadowHigh, blurRadius: 8, offset: const Offset(0, 4)),
            ],
          ),
          child: ClipOval(
            child: Image.network( // Replaced CustomImageWidget
              athleteData['profileImage'] as String,
              width: 20.w,
              height: 20.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      athleteData['name'] as String,
                      style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (athleteData['verified'] as bool)
                    Container(
                      margin: EdgeInsets.only(left: 2.w),
                      child: Icon( // Replaced CustomIconWidget
                        Icons.verified,
                        color: AppTheme.secondarySkyBlue,
                        size: 6.w,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                '${athleteData['sport']} • ${athleteData['position']}',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                '${athleteData['location']} • Age ${athleteData['age']}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverTabBar() {
    return SliverPersistentHeader(
      delegate: _SliverTabBarDelegate(
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Videos'),
            Tab(text: 'Analytics'),
            Tab(text: 'Achievements'),
          ],
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAchievementsBadges(),
            SizedBox(height: 3.h),
            _buildPerformanceMetrics(),
            SizedBox(height: 3.h),
            _buildBioSection(),
            SizedBox(height: 3.h),
            _buildQuickStats(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildVideosTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 16 / 12,
          ),
          itemCount: videoHighlights.length,
          itemBuilder: (context, index) {
            final video = videoHighlights[index];
            // TODO: Replace this placeholder with your own VideoHighlightWidget
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(video['thumbnail'] as String, fit: BoxFit.cover, height: 10.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(video['title'] as String, maxLines: 2),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // TODO: Replace this placeholder with your PerformanceChartWidget
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: const Center(child: Text('Placeholder for Performance Chart')),
            ),
            SizedBox(height: 2.h),
            // TODO: Replace this placeholder with your PerformanceChartWidget
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: const Center(child: Text('Placeholder for another Chart')),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // TODO: Replace this placeholder with your AchievementTimelineWidget
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: const Center(child: Text('Placeholder for Achievement Timeline')),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsBadges() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              // TODO: Replace this placeholder with your AchievementBadgeWidget
              return GestureDetector(
                onTap: () => _showAchievementDetails(achievement),
                child: Container(
                  width: 25.w,
                  margin: EdgeInsets.only(right: 3.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: AppTheme.championshipGold, size: 10.w),
                      SizedBox(height: 1.h),
                      Text(achievement['title'] as String, textAlign: TextAlign.center, maxLines: 2),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  // TODO: Create and import your PerformanceMetricCard widget to use here.
  // For now, this is a placeholder.
  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Metrics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 3.w,
          runSpacing: 2.h,
          children: performanceMetrics.map((metric) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(metric['title'] as String),
                    Text(metric['value'] as String),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.cardLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: AppTheme.shadowLight, blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: Text(
            athleteData['bio'] as String,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    final Map<String, dynamic> stats =
        athleteData['stats'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Stats',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.cardLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: AppTheme.shadowLight, blurRadius: 4, offset: const Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              _buildStatRow('Height', stats['height'] as String),
              _buildStatRow('Weight', stats['weight'] as String),
              _buildStatRow('Experience', stats['experience'] as String),
              _buildStatRow('Games Played', '${stats['gamesPlayed']}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.lightTheme.textTheme.bodyMedium),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/video-upload-and-analysis');
      },
      child: const Icon(Icons.add), // Replaced CustomIconWidget
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        boxShadow: [
          BoxShadow(color: AppTheme.shadowLight, blurRadius: 8, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/scout-network-and-connections');
                },
                icon: const Icon(Icons.person_add), // Replaced CustomIconWidget
                label: const Text('Connect'),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border), // Replaced CustomIconWidget
                label: const Text('Save Talent'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAchievementDetails(Map<String, dynamic> achievement) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(6.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 15.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.dividerLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 3.h),
              Icon( // Replaced CustomIconWidget
                Icons.emoji_events,
                size: 15.w,
                color: AppTheme.championshipGold,
              ),
              SizedBox(height: 2.h),
              Text(
                achievement['title'] as String,
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Congratulations on earning this achievement! This represents your dedication and hard work in your athletic journey.',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.backgroundLight,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}