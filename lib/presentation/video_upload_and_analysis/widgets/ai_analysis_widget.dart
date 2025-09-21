import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiAnalysisWidget extends StatefulWidget {
  final VoidCallback onComplete;
  final Map<String, dynamic> uploadData;

  const AiAnalysisWidget({
    Key? key,
    required this.onComplete,
    required this.uploadData,
  }) : super(key: key);

  @override
  State<AiAnalysisWidget> createState() => _AiAnalysisWidgetState();
}

class _AiAnalysisWidgetState extends State<AiAnalysisWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  double _analysisProgress = 0.0;
  String _currentStage = 'Initializing AI Analysis...';
  bool _isComplete = false;
  Map<String, dynamic>? _analysisResults;

  final List<String> _analysisStages = [
    'Initializing AI Analysis...',
    'Processing video frames...',
    'Analyzing movement patterns...',
    'Detecting technique markers...',
    'Comparing with benchmarks...',
    'Generating performance insights...',
    'Finalizing analysis report...',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnalysis();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _progressController.addListener(() {
      setState(() {
        _analysisProgress = _progressAnimation.value;
        final stageIndex =
            (_analysisProgress * (_analysisStages.length - 1)).floor();
        _currentStage =
            _analysisStages[stageIndex.clamp(0, _analysisStages.length - 1)];
      });
    });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _completeAnalysis();
      }
    });
  }

  void _startAnalysis() {
    _progressController.forward();
  }

  void _completeAnalysis() {
    setState(() {
      _isComplete = true;
      _analysisResults = _generateMockResults();
    });

    _pulseController.stop();

    // Auto-complete after showing results
    Future.delayed(Duration(seconds: 3), () {
      widget.onComplete();
    });
  }

  Map<String, dynamic> _generateMockResults() {
    return {
      'overallScore': 87,
      'techniqueScore': 92,
      'speedScore': 84,
      'accuracyScore': 89,
      'improvements': [
        'Maintain consistent follow-through',
        'Improve stance stability',
        'Increase rotation speed by 12%',
      ],
      'strengths': [
        'Excellent form consistency',
        'Strong power generation',
        'Good timing and rhythm',
      ],
      'benchmarkComparison': {
        'yourLevel': 'Advanced',
        'percentile': 78,
        'comparison': 'Above average for your age group',
      },
    };
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      color: AppTheme.neutralCharcoal,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 16,
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.primaryElectricBlue,
                  size: 28,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'AI Performance Analysis',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isComplete ? _buildResults() : _buildAnalysisProgress(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisProgress() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AI Brain Animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryElectricBlue,
                        AppTheme.secondarySkyBlue,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppTheme.primaryElectricBlue.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'psychology',
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 40),

          // Progress Bar
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _analysisProgress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryElectricBlue,
                      AppTheme.secondarySkyBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Progress Percentage
          Text(
            '${(_analysisProgress * 100).toInt()}%',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),

          // Current Stage
          Text(
            _currentStage,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),

          // Processing Info
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.accentGold,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Analysis in Progress',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.accentGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Our AI is analyzing your performance using advanced computer vision and machine learning algorithms. This process typically takes 30-60 seconds.',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_analysisResults == null) return SizedBox.shrink();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success Animation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: appTheme.getVictoryGradient(),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CustomIconWidget(
                  iconName: 'check_circle',
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(height: 12),
                Text(
                  'Analysis Complete!',
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your performance has been analyzed',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          // Overall Score
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryElectricBlue,
                  ),
                  child: Center(
                    child: Text(
                      '${_analysisResults!['overallScore']}',
                      style: AppTheme.lightTheme.textTheme.headlineMedium
                          ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Performance Score',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Excellent performance! You\'re in the top 25% of athletes.',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Detailed Scores
          Row(
            children: [
              Expanded(
                child: _buildScoreCard('Technique',
                    _analysisResults!['techniqueScore'], AppTheme.growthGreen),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildScoreCard('Speed', _analysisResults!['speedScore'],
                    AppTheme.accentGold),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildScoreCard('Accuracy',
                    _analysisResults!['accuracyScore'], AppTheme.victoryRed),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onComplete,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryElectricBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'View Full Analysis',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String title, int score, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$score',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
