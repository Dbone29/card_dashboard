import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPlaceholderCard extends StatelessWidget {
  const DashboardPlaceholderCard({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    required this.borderColor,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
