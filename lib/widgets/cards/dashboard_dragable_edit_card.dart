import 'package:card_dashboard/widgets/cards/dashboard_card_data.dart';
import 'package:card_dashboard/widgets/cards/dashboard_edit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardDragableEditCard extends StatefulWidget {
  const DashboardDragableEditCard({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    required this.backgroundColor,
    this.width = 1,
    this.height = 1,
    required this.onCardChanged,
    this.onPressedRemove,
    required this.child,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final int width;
  final int height;
  final void Function(DashboardCardData) onCardChanged;
  final void Function()? onPressedRemove;
  final Widget child;

  @override
  State<DashboardDragableEditCard> createState() =>
      _DashboardDragableEditCardState();
}

class _DashboardDragableEditCardState extends State<DashboardDragableEditCard> {
  double ydelta = 0;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: widget.width,
      mainAxisCellCount: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Draggable(
            feedback: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: DashboardEditCard(
                borderRadius: widget.borderRadius,
                backgroundColor: widget.backgroundColor,
                child: widget.child,
              ),
            ),
            child: DashboardEditCard(
              borderRadius: widget.borderRadius,
              backgroundColor: widget.backgroundColor,
              onPressedRemove: widget.onPressedRemove,
              onVerticalDragUpdate: (details) {
                int newHeight = details.globalPosition.dy ~/
                    (constraints.maxHeight / widget.height);

                if (newHeight > 0) {
                  widget.onCardChanged(DashboardCardData(
                    xSize: widget.width,
                    ySize: newHeight,
                    backgroundColor: widget.backgroundColor,
                    child: widget.child,
                  ));
                }
              },
              onHorizontalDragUpdate: (details) {
                int newWidth = details.globalPosition.dx ~/
                    ((constraints.maxWidth / widget.width));

                if (newWidth > 0) {
                  widget.onCardChanged(DashboardCardData(
                    xSize: newWidth,
                    ySize: widget.height,
                    backgroundColor: widget.backgroundColor,
                    child: widget.child,
                  ));
                }
              },
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
