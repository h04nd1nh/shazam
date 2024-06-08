import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shazam/pages/about/about.dart';
import 'package:shazam/pages/overview/over_view.dart';
import 'package:shazam/pages/shazam/shazam.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with TickerProviderStateMixin {
  List<Widget> page = [OverviewPage(), AboutPage()];
  List<IconData> iconList = [Icons.music_note, Icons.album_outlined];
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShazamPage()),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Color(0xff0186ff),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            'assets/img/shazam-logo.png',
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 60,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
