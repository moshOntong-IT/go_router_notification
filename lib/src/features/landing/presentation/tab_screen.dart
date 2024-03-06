import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({this.tab, super.key});

  final int? tab;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 2 tabs. Adjust the length for more tabs.
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: widget.tab ?? 0,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Tab Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car), text: 'Car'),
            Tab(icon: Icon(Icons.directions_transit), text: 'Transit'),
            Tab(icon: Icon(Icons.directions_transit), text: 'Traffic'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('Car Tab Content')),
          Center(child: Text('Transit Tab Content')),
          Center(child: Text('Traffic Tab Content')),
        ],
      ),
    );
  }
}
