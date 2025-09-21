import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_export.dart';
import './widgets/ai_analysis_widget.dart';
import './widgets/camera_preview_widget.dart';
import './widgets/performance_type_widget.dart';
import './widgets/sport_selection_widget.dart';
import './widgets/upload_form_widget.dart';
import './widgets/video_review_widget.dart';

class VideoUploadAndAnalysis extends StatefulWidget {
  const VideoUploadAndAnalysis({Key? key}) : super(key: key);

  @override
  State<VideoUploadAndAnalysis> createState() => _VideoUploadAndAnalysisState();
}

class _VideoUploadAndAnalysisState extends State<VideoUploadAndAnalysis>
    with TickerProviderStateMixin {
  // Camera related
  List<CameraDescription> _cameras = [];
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  String _recordingDuration = '00:00';
  int _recordingSeconds = 0;
  String? _capturedVideoPath;
  String? _capturedImagePath;

  // UI State
  PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedSport = '';
  String _selectedPerformanceType = '';
  Map<String, dynamic>? _uploadFormData;

  // Recording timer
  late AnimationController _timerController;

  final List<String> _pageSteps = [
    'Setup',
    'Record',
    'Review',
    'Upload',
    'Analysis',
  ];

  @override
  void initState() {
    super.initState();
    _initializeTimerController();
    _requestPermissions();
  }

  void _initializeTimerController() {
    _timerController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        if (_isRecording) {
          setState(() {
            _recordingSeconds++;
            final minutes = _recordingSeconds ~/ 60;
            final seconds = _recordingSeconds % 60;
            _recordingDuration =
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
          });
        }
      });
  }

  Future<void> _requestPermissions() async {
    if (kIsWeb) {
      _initializeCamera();
      return;
    }

    final cameraStatus = await Permission.camera.request();
    final microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      _initializeCamera();
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permissions Required'),
        content: Text(
            'Camera and microphone permissions are required to record videos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestPermissions();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first,
            )
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first,
            );

      _cameraController = CameraController(
        camera,
        kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
        enableAudio: true,
      );

      await _cameraController!.initialize();
      await _applySettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
      if (!kIsWeb) {
        try {
          await _cameraController!.setFlashMode(FlashMode.auto);
        } catch (e) {
          print('Flash mode not supported: $e');
        }
      }
    } catch (e) {
      print('Error applying camera settings: $e');
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2) return;

    final currentLensDirection = _cameraController!.description.lensDirection;
    final newCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection != currentLensDirection,
      orElse: () => _cameras.first,
    );

    await _cameraController!.dispose();
    _cameraController = CameraController(
      newCamera,
      kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
      enableAudio: true,
    );

    await _cameraController!.initialize();
    await _applySettings();
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      await _cameraController!.startVideoRecording();
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
        _recordingDuration = '00:00';
      });
      _timerController.repeat();
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController == null || !_isRecording) return;

    try {
      final videoFile = await _cameraController!.stopVideoRecording();
      _timerController.stop();
      setState(() {
        _isRecording = false;
        _capturedVideoPath = videoFile.path;
      });
      _goToReviewPage();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final imageFile = await _cameraController!.takePicture();
      setState(() {
        _capturedImagePath = imageFile.path;
      });
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  Future<void> _selectFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _capturedVideoPath = pickedFile.path;
      });
      _goToReviewPage();
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToReviewPage() {
    _goToPage(2);
  }

  void _goToUploadPage() {
    _goToPage(3);
  }

  void _goToAnalysisPage() {
    _goToPage(4);
  }

  void _handleUploadSubmit(Map<String, dynamic> formData) {
    setState(() {
      _uploadFormData = formData;
    });
    _goToAnalysisPage();
  }

  void _handleAnalysisComplete() {
    Navigator.pushReplacementNamed(context, '/athlete-profile');
  }

  void _showSportSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SportSelectionWidget(
        selectedSport: _selectedSport,
        onSportSelected: (sport) {
          setState(() {
            _selectedSport = sport;
            _selectedPerformanceType = ''; // Reset performance type
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showPerformanceTypeSelection() {
    if (_selectedSport.isEmpty) {
      _showSportSelection();
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PerformanceTypeWidget(
        selectedType: _selectedPerformanceType,
        selectedSport: _selectedSport,
        onTypeSelected: (type) {
          setState(() {
            _selectedPerformanceType = type;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _pageController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralCharcoal,
      body: Column(
        children: [
          // Header with progress
          _buildHeader(),

          // Main Content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildSetupPage(),
                _buildRecordPage(),
                _buildReviewPage(),
                _buildUploadPage(),
                _buildAnalysisPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.neutralCharcoal,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Top Row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  _pageSteps[_currentPage],
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${_currentPage + 1}/${_pageSteps.length}',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Progress Bar
          Row(
            children: List.generate(_pageSteps.length, (index) {
              final isActive = index <= _currentPage;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                      right: index < _pageSteps.length - 1 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppTheme.primaryElectricBlue
                        : Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSetupPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Setup',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Configure your recording settings for optimal AI analysis',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 32),

          // Sport Selection
          GestureDetector(
            onTap: _showSportSelection,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedSport.isNotEmpty
                      ? AppTheme.primaryElectricBlue
                      : Colors.white.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          AppTheme.primaryElectricBlue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomIconWidget(
                      iconName: 'sports',
                      color: AppTheme.primaryElectricBlue,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sport',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _selectedSport.isEmpty
                              ? 'Select your sport'
                              : _selectedSport,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: _selectedSport.isEmpty
                                ? Colors.white.withValues(alpha: 0.6)
                                : AppTheme.primaryElectricBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Performance Type Selection
          GestureDetector(
            onTap: _showPerformanceTypeSelection,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedPerformanceType.isNotEmpty
                      ? AppTheme.accentGold
                      : Colors.white.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomIconWidget(
                      iconName: 'fitness_center',
                      color: AppTheme.accentGold,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Performance Type',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _selectedPerformanceType.isEmpty
                              ? 'Select performance type'
                              : _selectedPerformanceType,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: _selectedPerformanceType.isEmpty
                                ? Colors.white.withValues(alpha: 0.6)
                                : AppTheme.accentGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          Spacer(),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedSport.isNotEmpty &&
                      _selectedPerformanceType.isNotEmpty
                  ? () => _goToPage(1)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryElectricBlue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Start Recording',
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

  Widget _buildRecordPage() {
    return Column(
      children: [
        Expanded(
          child: CameraPreviewWidget(
            cameraController: _cameraController,
            isRecording: _isRecording,
            recordingDuration: _recordingDuration,
            onStartRecording: _startRecording,
            onStopRecording: _stopRecording,
            onFlipCamera: _flipCamera,
            onCapture: _capturePhoto,
          ),
        ),

        // Recording Tips
        Container(
          padding: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'lightbulb',
                  color: AppTheme.accentGold,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Keep the camera steady and ensure good lighting for best analysis results',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewPage() {
    if (_capturedVideoPath == null) {
      return Center(
        child: Text(
          'No video captured',
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      );
    }

    return VideoReviewWidget(
      videoPath: _capturedVideoPath!,
      onRetake: () => _goToPage(1),
      onProceed: _goToUploadPage,
    );
  }

  Widget _buildUploadPage() {
    return UploadFormWidget(
      onSubmit: _handleUploadSubmit,
      onCancel: () => _goToPage(2),
    );
  }

  Widget _buildAnalysisPage() {
    return AiAnalysisWidget(
      onComplete: _handleAnalysisComplete,
      uploadData: _uploadFormData ?? {},
    );
  }
}
