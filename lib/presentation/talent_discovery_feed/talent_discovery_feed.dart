import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/athlete_card_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/search_header_widget.dart';

class TalentDiscoveryFeed extends StatefulWidget {
  const TalentDiscoveryFeed({Key? key}) : super(key: key);

  @override
  State<TalentDiscoveryFeed> createState() => _TalentDiscoveryFeedState();
}

class _TalentDiscoveryFeedState extends State<TalentDiscoveryFeed>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _selectedTabIndex = 0;
  bool _isLoading = false;
  bool _isRefreshing = false;
  Map<String, dynamic> _activeFilters = {};
  List<Map<String, dynamic>> _athletes = [];
  List<Map<String, dynamic>> _filteredAthletes = [];

  late TabController _tabController;

  // Mock data for athletes
  final List<Map<String, dynamic>> _mockAthletes = [
    {
      "id": 1,
      "name": "Marcus Johnson",
      "sport": "Football",
      "location": "Texas, USA",
      "profileImage":
          "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "1:45",
      "talentScore": 92,
      "isVerified": true,
      "topSpeed": "28.5",
      "goals": 15,
      "matches": 22,
      "age": 19,
      "achievements": [
        {"title": "State Champion", "year": 2024},
        {"title": "MVP Award", "year": 2024},
        {"title": "Top Scorer", "year": 2023}
      ]
    },
    {
      "id": 2,
      "name": "Sofia Rodriguez",
      "sport": "Basketball",
      "location": "California, USA",
      "profileImage":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/1752757/pexels-photo-1752757.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "2:12",
      "talentScore": 88,
      "isVerified": true,
      "topSpeed": "24.2",
      "goals": 28,
      "matches": 18,
      "age": 20,
      "achievements": [
        {"title": "All-Star Player", "year": 2024},
        {"title": "Best Shooter", "year": 2024}
      ]
    },
    {
      "id": 3,
      "name": "David Chen",
      "sport": "Tennis",
      "location": "New York, USA",
      "profileImage":
          "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/209977/pexels-photo-209977.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "1:28",
      "talentScore": 85,
      "isVerified": false,
      "topSpeed": "0",
      "goals": 0,
      "matches": 35,
      "age": 18,
      "achievements": [
        {"title": "Regional Winner", "year": 2024}
      ]
    },
    {
      "id": 4,
      "name": "Emma Thompson",
      "sport": "Swimming",
      "location": "Florida, USA",
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "0:58",
      "talentScore": 94,
      "isVerified": true,
      "topSpeed": "0",
      "goals": 0,
      "matches": 12,
      "age": 17,
      "achievements": [
        {"title": "National Record", "year": 2024},
        {"title": "Olympic Qualifier", "year": 2024},
        {"title": "World Junior Champion", "year": 2023}
      ]
    },
    {
      "id": 5,
      "name": "James Wilson",
      "sport": "Baseball",
      "location": "Illinois, USA",
      "profileImage":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/1661950/pexels-photo-1661950.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "1:33",
      "talentScore": 79,
      "isVerified": false,
      "topSpeed": "0",
      "goals": 0,
      "matches": 28,
      "age": 21,
      "achievements": [
        {"title": "Home Run King", "year": 2024}
      ]
    },
    {
      "id": 6,
      "name": "Aisha Patel",
      "sport": "Cricket",
      "location": "Georgia, USA",
      "profileImage":
          "https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=400",
      "videoThumbnail":
          "https://images.pexels.com/photos/1661950/pexels-photo-1661950.jpeg?auto=compress&cs=tinysrgb&w=800",
      "videoDuration": "2:05",
      "talentScore": 82,
      "isVerified": true,
      "topSpeed": "0",
      "goals": 0,
      "matches": 15,
      "age": 19,
      "achievements": [
        {"title": "Best Bowler", "year": 2024},
        {"title": "Player of the Match", "year": 2024}
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _athletes = List.from(_mockAthletes);
    _filteredAthletes = List.from(_athletes);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreAthletes();
    }
  }

  Future<void> _loadMoreAthletes() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Add more mock data
    final moreAthletes = List.generate(3, (index) {
      final baseAthlete = _mockAthletes[index % _mockAthletes.length];
      return {
        ...baseAthlete,
        'id': _athletes.length + index + 1,
        'name': '${baseAthlete['name']} ${index + 1}',
      };
    });

    setState(() {
      _athletes.addAll(moreAthletes);
      _applyFilters();
      _isLoading = false;
    });
  }

  Future<void> _refreshFeed() async {
    setState(() => _isRefreshing = true);
    HapticFeedback.mediumImpact();

    // Simulate API refresh
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _athletes = List.from(_mockAthletes);
      _applyFilters();
      _isRefreshing = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAthletes = List.from(_athletes);
      } else {
        _filteredAthletes = _athletes.where((athlete) {
          final name = (athlete['name'] as String).toLowerCase();
          final sport = (athlete['sport'] as String).toLowerCase();
          final location = (athlete['location'] as String).toLowerCase();
          final searchQuery = query.toLowerCase();

          return name.contains(searchQuery) ||
              sport.contains(searchQuery) ||
              location.contains(searchQuery);
        }).toList();
      }
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        currentFilters: _activeFilters,
        onFiltersApplied: (filters) {
          setState(() {
            _activeFilters = filters;
            _applyFilters();
          });
        },
      ),
    );
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(_athletes);

    // Apply search filter
    final searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((athlete) {
        final name = (athlete['name'] as String).toLowerCase();
        final sport = (athlete['sport'] as String).toLowerCase();
        final location = (athlete['location'] as String).toLowerCase();

        return name.contains(searchQuery) ||
            sport.contains(searchQuery) ||
            location.contains(searchQuery);
      }).toList();
    }

    // Apply sport filter
    final selectedSports = _activeFilters['selectedSports'] as List?;
    if (selectedSports != null && selectedSports.isNotEmpty) {
      filtered = filtered
          .where((athlete) => selectedSports.contains(athlete['sport']))
          .toList();
    }

    // Apply location filter
    final selectedLocations = _activeFilters['selectedLocations'] as List?;
    if (selectedLocations != null && selectedLocations.isNotEmpty) {
      filtered = filtered.where((athlete) {
        final location = athlete['location'] as String;
        return selectedLocations
            .any((selectedLocation) => location.contains(selectedLocation));
      }).toList();
    }

    // Apply skill level filter
    final selectedSkillLevel = _activeFilters['selectedSkillLevel'] as String?;
    if (selectedSkillLevel != null) {
      filtered = filtered.where((athlete) {
        final score = athlete['talentScore'] as int;
        switch (selectedSkillLevel) {
          case 'Elite':
            return score >= 90;
          case 'Professional':
            return score >= 80 && score < 90;
          case 'Advanced':
            return score >= 70 && score < 80;
          case 'Intermediate':
            return score >= 60 && score < 70;
          case 'Beginner':
            return score < 60;
          default:
            return true;
        }
      }).toList();
    }

    // Apply talent score range filter
    final minScore = _activeFilters['minScore'] as int?;
    final maxScore = _activeFilters['maxScore'] as int?;
    if (minScore != null && maxScore != null) {
      filtered = filtered.where((athlete) {
        final score = athlete['talentScore'] as int;
        return score >= minScore && score <= maxScore;
      }).toList();
    }

    // Apply age range filter
    final minAge = _activeFilters['minAge'] as int?;
    final maxAge = _activeFilters['maxAge'] as int?;
    if (minAge != null && maxAge != null) {
      filtered = filtered.where((athlete) {
        final age = athlete['age'] as int;
        return age >= minAge && age <= maxAge;
      }).toList();
    }

    // Apply verification filter
    final verifiedOnly = _activeFilters['verifiedOnly'] as bool?;
    if (verifiedOnly == true) {
      filtered =
          filtered.where((athlete) => athlete['isVerified'] == true).toList();
    }

    setState(() {
      _filteredAthletes = filtered;
    });
  }

  void _removeFilter(String filterType) {
    setState(() {
      switch (filterType) {
        case 'sport':
          _activeFilters.remove('selectedSports');
          break;
        case 'location':
          _activeFilters.remove('selectedLocations');
          break;
        case 'skill':
          _activeFilters.remove('selectedSkillLevel');
          break;
      }
      _applyFilters();
    });
  }

  void _onAthleteCardTap(Map<String, dynamic> athlete) {
    Navigator.pushNamed(context, '/athlete-profile');
  }

  void _onAthleteInterested(Map<String, dynamic> athlete) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Marked ${athlete['name']} as interested!'),
        backgroundColor: AppTheme.growthGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onAthleteConnect(Map<String, dynamic> athlete) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connection request sent to ${athlete['name']}!'),
        backgroundColor: AppTheme.primaryElectricBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onAthletePass(Map<String, dynamic> athlete) {
    HapticFeedback.lightImpact();
    setState(() {
      _filteredAthletes.removeWhere((a) => a['id'] == athlete['id']);
    });
  }

  void _onNotificationTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notifications feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onTabChanged(int index) {
    setState(() => _selectedTabIndex = index);

    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/athlete-profile');
        break;
      case 2:
        Navigator.pushNamed(context, '/ai-performance-analytics-dashboard');
        break;
      case 3:
        Navigator.pushNamed(context, '/scout-network-and-connections');
        break;
      case 4:
        // More tab - show options
        break;
    }
  }

  void _onUploadTalent() {
    Navigator.pushNamed(context, '/video-upload-and-analysis');
  }

  void _onExpandSearchCriteria() {
    _showFilterBottomSheet();
  }

  List<String> _getActiveFilterLabels() {
    List<String> labels = [];

    final selectedSports = _activeFilters['selectedSports'] as List?;
    if (selectedSports != null && selectedSports.isNotEmpty) {
      labels.add(
          '${selectedSports.length} Sport${selectedSports.length > 1 ? 's' : ''}');
    }

    final selectedLocations = _activeFilters['selectedLocations'] as List?;
    if (selectedLocations != null && selectedLocations.isNotEmpty) {
      labels.add(
          '${selectedLocations.length} Location${selectedLocations.length > 1 ? 's' : ''}');
    }

    final selectedSkillLevel = _activeFilters['selectedSkillLevel'] as String?;
    if (selectedSkillLevel != null) {
      labels.add(selectedSkillLevel);
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          SearchHeaderWidget(
            searchController: _searchController,
            onFilterTap: _showFilterBottomSheet,
            onNotificationTap: _onNotificationTap,
            onSearchChanged: _onSearchChanged,
          ),
          if (_getActiveFilterLabels().isNotEmpty) _buildActiveFilters(),
          Expanded(
            child: _filteredAthletes.isEmpty
                ? _buildEmptyState()
                : _buildAthletesFeed(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onUploadTalent,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 28,
        ),
        tooltip: 'Upload Your Talent',
      ),
    );
  }

  Widget _buildActiveFilters() {
    final filterLabels = _getActiveFilterLabels();

    return Container(
      height: 6.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterLabels.length,
        itemBuilder: (context, index) {
          final label = filterLabels[index];
          return FilterChipWidget(
            label: label,
            isSelected: true,
            onRemove: () => _removeFilter(_getFilterTypeFromLabel(label)),
          );
        },
      ),
    );
  }

  String _getFilterTypeFromLabel(String label) {
    if (label.contains('Sport')) return 'sport';
    if (label.contains('Location')) return 'location';
    return 'skill';
  }

  Widget _buildAthletesFeed() {
    return RefreshIndicator(
      onRefresh: _refreshFeed,
      color: AppTheme.primaryElectricBlue,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _filteredAthletes.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _filteredAthletes.length) {
            return _buildLoadingIndicator();
          }

          final athlete = _filteredAthletes[index];
          return AthleteCardWidget(
            athlete: athlete,
            onTap: () => _onAthleteCardTap(athlete),
            onInterested: () => _onAthleteInterested(athlete),
            onConnect: () => _onAthleteConnect(athlete),
            onPass: () => _onAthletePass(athlete),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryElectricBlue,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final hasActiveFilters = _activeFilters.isNotEmpty;

    return EmptyStateWidget(
      title: hasActiveFilters ? 'No Athletes Found' : 'Discover Amazing Talent',
      subtitle: hasActiveFilters
          ? 'Try adjusting your search criteria or filters to find more athletes.'
          : 'Connect with talented athletes from around the world and discover the next sports stars.',
      buttonText:
          hasActiveFilters ? 'Expand Search Criteria' : 'Upload Your Talent',
      iconName: hasActiveFilters ? 'search_off' : 'sports',
      onButtonPressed:
          hasActiveFilters ? _onExpandSearchCriteria : _onUploadTalent,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedTabIndex,
      onTap: _onTabChanged,
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
      selectedLabelStyle:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
      unselectedLabelStyle:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
      elevation: 8.0,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'home',
            color: _selectedTabIndex == 0
                ? AppTheme.primaryElectricBlue
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'person',
            color: _selectedTabIndex == 1
                ? AppTheme.primaryElectricBlue
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'analytics',
            color: _selectedTabIndex == 2
                ? AppTheme.primaryElectricBlue
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'group',
            color: _selectedTabIndex == 3
                ? AppTheme.primaryElectricBlue
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          label: 'Network',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'more_horiz',
            color: _selectedTabIndex == 4
                ? AppTheme.primaryElectricBlue
                : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          label: 'More',
        ),
      ],
    );
  }
}
