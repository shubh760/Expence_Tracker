import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:expence_tracker/constants.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int curridx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavyBarItem(icon: Icon(Icons.list), title: Text('Recents')),
          BottomNavyBarItem(icon: Icon(Icons.star), title: Text('Reward')),
          BottomNavyBarItem(icon: Icon(Icons.coffee_rounded), title: Text('Blogs')),
        ],
        onItemSelected: (index) {
          setState(() {
            curridx = index;
          });
        },
        selectedIndex: curridx,
      ),
      body: pages[curridx],
    );
  }
}
