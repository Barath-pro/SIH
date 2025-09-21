import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/app_export.dart';

// TODO: When you create your custom widgets, you will need to import them here.
// import './widgets/connection_section_widget.dart';
// import './widgets/filter_bottom_sheet_widget.dart';
// import './widgets/search_bar_widget.dart';

class ScoutNetworkAndConnections extends StatefulWidget {
  const ScoutNetworkAndConnections({Key? key}) : super(key: key);

  @override
  State<ScoutNetworkAndConnections> createState() =>
      _ScoutNetworkAndConnectionsState();
}

class _ScoutNetworkAndConnectionsState
    extends State<ScoutNetworkAndConnections> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String _searchQuery = '';
  
  // Mock data for a list of athletes to display
  final List<Map<String, dynamic>> _connections = List.generate(
    20,
    (index) => {
      'name': 'Athlete #${index + 1}',
      'sport': 'Basketball',
      'location': 'New York, NY',
      'profileImage': 'https://i.pravatar.cc/150?img=$index',
    },
  );

  // Method to show the filter sheet (placeholder)
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // TODO: Replace this Container with your 'FilterBottomSheetWidget'
        return Container(
          height: 50.h,
          child: Center(
            child: Text(
              'Filter Options Here',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // Simulate a network request
          await Future.delayed(const Duration(seconds: 1));
        },
        // TODO: Replace this ListView with your 'ConnectionSectionWidget'
        child: ListView.builder(
          itemCount: _connections.length,
          itemBuilder: (context, index) {
            final connection = _connections[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(connection['profileImage']),
              ),
              title: Text(connection['name']),
              subtitle: Text('${connection['sport']} - ${connection['location']}'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to athlete's profile
              },
            );
          },
        ),
      ),
    );
  }

  // Helper widget to build the search bar
  Widget _buildSearchBar() {
    // TODO: Replace this TextField with your 'SearchBarWidget'
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
          // You can add search filtering logic here
        });
      },
      decoration: InputDecoration(
        hintText: 'Search athletes, teams...',
        prefixIcon: Icon(Icons.search),
        border: InputBorder.none,
      ),
    );
  }
}