import 'package:flutter/material.dart';

class DashboardCardData {
  const DashboardCardData({
    this.xSize = 1,
    this.ySize = 1,
    required this.backgroundColor,
    required this.child,
  });

  final int xSize;
  final int ySize;
  final Color backgroundColor;
  final Widget child;

  int getSlotSize() {
    return xSize * ySize;
  }
}
