import 'package:card_dashboard/widgets/cards/dashboard_card_data.dart';
import 'package:card_dashboard/widgets/cards/dashboard_dragable_edit_card.dart';
import 'package:card_dashboard/widgets/cards/dashboard_view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({
    super.key,
    this.spacing = 4,
    this.horizontalCount = 5,
    this.editMode = false,
    required this.cards,
    required this.onCardListChanged,
  });

  final double spacing;
  final int horizontalCount;
  final bool editMode;
  final List<DashboardCardData> cards;
  final void Function(List<DashboardCardData>) onCardListChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacing),
      child: StaggeredGrid.count(
        axisDirection: AxisDirection.down,
        crossAxisCount: horizontalCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        children: [
          if (!editMode)
            ...cards
                .map((e) => DashboardViewCard(
                      width: e.xSize,
                      height: e.ySize,
                      backgroundColor: e.backgroundColor,
                      child: e.child,
                    ))
                .toList(),
          if (editMode)
            for (int i = 0; i < cards.length; i++)
              DashboardDragableEditCard(
                width: cards[i].xSize,
                height: cards[i].ySize,
                backgroundColor: cards[i].backgroundColor,
                onPressedRemove: () {
                  List<DashboardCardData> newcards = cards.toList();

                  newcards.removeAt(i);

                  onCardListChanged(newcards);
                },
                onCardChanged: (newCard) {
                  List<DashboardCardData> newcards = cards;

                  newcards[i] = newCard;

                  onCardListChanged(newcards);
                },
                child: cards[i].child,
              )
        ],
      ),
    );
  }

  int getPlaceholderCount() {
    int totalSlotsUsed =
        cards.map((e) => e.getSlotSize()).reduce((a, b) => a + b);

    return (horizontalCount * 2) - (totalSlotsUsed % horizontalCount);
  }
}
