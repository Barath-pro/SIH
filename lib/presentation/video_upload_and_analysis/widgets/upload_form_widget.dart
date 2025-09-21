import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UploadFormWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onCancel;

  const UploadFormWidget({
    Key? key,
    required this.onSubmit,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<UploadFormWidget> createState() => _UploadFormWidgetState();
}

class _UploadFormWidgetState extends State<UploadFormWidget> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _privacySetting = 'Public';
  bool _allowComments = true;
  bool _shareToFeed = true;

  final List<String> _privacyOptions = ['Public', 'Scouts Only', 'Private'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a title for your video'),
          backgroundColor: AppTheme.victoryRed,
        ),
      );
      return;
    }

    final formData = {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'privacy': _privacySetting,
      'allowComments': _allowComments,
      'shareToFeed': _shareToFeed,
    };

    widget.onSubmit(formData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.dividerLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onCancel,
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.neutralCharcoal,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Upload Details',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralCharcoal,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _handleSubmit,
                  child: Text(
                    'Upload',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryElectricBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  Text(
                    'Video Title *',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralCharcoal,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText:
                          'Enter a descriptive title for your performance',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12),
                        child: CustomIconWidget(
                          iconName: 'title',
                          color: AppTheme.textMediumEmphasisLight,
                          size: 20,
                        ),
                      ),
                    ),
                    maxLength: 100,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 24),

                  // Description Field
                  Text(
                    'Description',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralCharcoal,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText:
                          'Add details about your performance, goals, or what you\'d like feedback on...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12, top: 12),
                        child: CustomIconWidget(
                          iconName: 'description',
                          color: AppTheme.textMediumEmphasisLight,
                          size: 20,
                        ),
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 24),

                  // Privacy Settings
                  Text(
                    'Privacy Settings',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralCharcoal,
                    ),
                  ),
                  SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.dividerLight),
                    ),
                    child: Column(
                      children: _privacyOptions.map((option) {
                        final isSelected = _privacySetting == option;
                        IconData iconData;
                        String description;

                        switch (option) {
                          case 'Public':
                            iconData = Icons.public;
                            description = 'Visible to everyone on the platform';
                            break;
                          case 'Scouts Only':
                            iconData = Icons.verified_user;
                            description = 'Only verified scouts can view';
                            break;
                          case 'Private':
                            iconData = Icons.lock;
                            description = 'Only you can view this video';
                            break;
                          default:
                            iconData = Icons.public;
                            description = '';
                        }

                        return GestureDetector(
                          onTap: () => setState(() => _privacySetting = option),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryElectricBlue
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppTheme.primaryElectricBlue
                                        : AppTheme.lightGray,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    iconData,
                                    color: isSelected
                                        ? Colors.white
                                        : AppTheme.textMediumEmphasisLight,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        option,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? AppTheme.primaryElectricBlue
                                              : AppTheme.neutralCharcoal,
                                        ),
                                      ),
                                      Text(
                                        description,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                          color:
                                              AppTheme.textMediumEmphasisLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  CustomIconWidget(
                                    iconName: 'check_circle',
                                    color: AppTheme.primaryElectricBlue,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Additional Options
                  Text(
                    'Additional Options',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralCharcoal,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Allow Comments Toggle
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.dividerLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: 'comment',
                            color: AppTheme.accentGold,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Allow Comments',
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.neutralCharcoal,
                                ),
                              ),
                              Text(
                                'Let others provide feedback and encouragement',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textMediumEmphasisLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _allowComments,
                          onChanged: (value) =>
                              setState(() => _allowComments = value),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Share to Feed Toggle
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.dividerLight),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.growthGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: 'share',
                            color: AppTheme.growthGreen,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Share to Discovery Feed',
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.neutralCharcoal,
                                ),
                              ),
                              Text(
                                'Make your video discoverable to scouts and coaches',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textMediumEmphasisLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _shareToFeed,
                          onChanged: (value) =>
                              setState(() => _shareToFeed = value),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
