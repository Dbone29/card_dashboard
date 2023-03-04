import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardViewCard extends StatelessWidget {
  const DashboardViewCard({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    required this.backgroundColor,
    this.width = 1,
    this.height = 1,
    required this.child,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final int width;
  final int height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: width,
      mainAxisCellCount: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: backgroundColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
