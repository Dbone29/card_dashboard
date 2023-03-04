import 'package:flutter/material.dart';

class DashboardEditCard extends StatelessWidget {
  const DashboardEditCard({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    required this.backgroundColor,
    this.width = 1,
    this.height = 1,
    this.onVerticalDragUpdate,
    this.onHorizontalDragUpdate,
    this.onPressedRemove,
    required this.child,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final int width;
  final int height;

  final void Function(DragUpdateDetails)? onVerticalDragUpdate;
  final void Function(DragUpdateDetails)? onHorizontalDragUpdate;

  final void Function()? onPressedRemove;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.edit,
                          size: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: null,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: onVerticalDragUpdate,
                      onHorizontalDragUpdate: onHorizontalDragUpdate,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.train,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
