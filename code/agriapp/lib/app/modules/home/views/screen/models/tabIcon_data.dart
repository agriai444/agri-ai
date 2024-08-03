import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData icon;
  IconData selectedIcon;
  String label;
  bool isSelected;
  int index;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = [
    TabIconData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
      index: 0,
      isSelected: true,
    ),
    TabIconData(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
      label: 'Chat AI',
      index: 1,
      isSelected: false,
    ),
    TabIconData(
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble_sharp,
      label: 'Chat',
      index: 2,
      isSelected: false,
    ),
    TabIconData(
      icon: Icons.more,
      selectedIcon: Icons.more,
      label: 'More',
      index: 3,
      isSelected: false,
    ),
  ];
}