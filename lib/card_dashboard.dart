library card_dashboard;

import 'package:flutter/material.dart';

class CardDashboard extends StatefulWidget {
  const CardDashboard({
    super.key,
    this.children = const [],
    this.rowCount = 5,
    this.columnCount = 5,
    required this.onChanged,
  });

  final List<DashboardDraggableCard> children;
  final int rowCount;
  final int columnCount;
  final Function(List<DashboardDraggableCard>) onChanged;

  @override
  State<CardDashboard> createState() => _CardDashboardState();
}

class _CardDashboardState extends State<CardDashboard> {
  List<ValueNotifier<GridPositionedWidget>> cards = [];

  @override
  void initState() {
    super.initState();
    //cards = [];
    _sortList(widget.children);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.rowCount,
      shrinkWrap: true,
      children: cards
          .map(
            (e) => ValueListenableBuilder(
              valueListenable: e,
              builder: (context, value, child) {
                if (value is DashboardDraggableCard) {
                  return value;
                }
                return value as Widget;
              },
            ),
          )
          .toList(),
    );
  }

  _sortList(List<DashboardDraggableCard> list) {
    var buffer = list.toList();

    buffer.sort((a, b) {
      if (a.y < b.y) {
        return -1;
      } else if (a.y > b.y) {
        return 1;
      }

      if (a.x < b.x) {
        return -1;
      } else if (a.x > b.x) {
        return 1;
      }

      return 0;
    });

    for (DashboardDraggableCard card in buffer) {
      while (cards.length < card.x + (widget.rowCount * card.y)) {
        cards.add(ValueNotifier(DashboardDragTargetCard(
          x: cards.length % widget.rowCount,
          y: cards.length ~/ widget.rowCount,
          onAccept: _onAccept,
        )));
      }
      cards.add(ValueNotifier(DashboardDraggableCard(
        x: cards.length % widget.rowCount,
        y: cards.length ~/ widget.rowCount,
        child: card.child,
      )));
    }

    while (cards.length < widget.rowCount * widget.columnCount) {
      cards.add(ValueNotifier(DashboardDragTargetCard(
        x: cards.length % widget.rowCount,
        y: cards.length ~/ widget.rowCount,
        onAccept: _onAccept,
      )));
    }
  }

  _onAccept(DashboardDraggableCard old, DashboardDraggableCard ne) {
    int oldIndex = cards.indexWhere((element) => element.value == old);
    int newIndex = cards.indexWhere(
        (element) => element.value.x == ne.x && element.value.y == ne.y);

    cards[oldIndex].value = DashboardDragTargetCard(
      x: old.x,
      y: old.y,
      onAccept: _onAccept,
    );

    cards[newIndex].value = ne;

    widget.onChanged.call(cards
        .where((element) => element.value is DashboardDraggableCard)
        .map((e) => e.value as DashboardDraggableCard)
        .toList());
  }
}

abstract class GridPositionedWidget {
  const GridPositionedWidget({required this.x, required this.y});

  final int x;
  final int y;
}

class DashboardDragTargetCard extends StatefulWidget
    implements GridPositionedWidget {
  const DashboardDragTargetCard({
    super.key,
    required this.x,
    required this.y,
    this.child,
    this.onAccept,
  });

  @override
  final int x;
  @override
  final int y;

  final Widget? child;
  final Function(DashboardDraggableCard, DashboardDraggableCard)? onAccept;

  @override
  State<DashboardDragTargetCard> createState() =>
      _DashboardDragTargetCardState();
}

class _DashboardDragTargetCardState extends State<DashboardDragTargetCard> {
  ValueNotifier<bool> isOnDragable = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return DragTarget<DashboardDraggableCard>(
      onAccept: (data) {
        debugPrint(data.toString());
        widget.onAccept?.call(
          data,
          DashboardDraggableCard(
            x: widget.x,
            y: widget.y,
            child: data.child,
          ),
        );

        debugPrint('data is $data with ${data.x} ${data.y}');
      },
      onLeave: (details) {
        isOnDragable.value = false;
      },
      onMove: (details) {
        isOnDragable.value = true;
      },
      builder: (context, a, b) {
        return ValueListenableBuilder(
          valueListenable: isOnDragable,
          builder: (context, value, child) {
            if (value) {
              return Container(
                color: Colors.grey,
              );
            }
            return Container();
          },
        );
      },
    );
  }
}

class DashboardDraggableCard extends StatelessWidget
    implements GridPositionedWidget {
  const DashboardDraggableCard({
    super.key,
    required this.x,
    required this.y,
    this.child,
  });

  @override
  final int x;
  @override
  final int y;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Draggable(
        data: this,
        feedback: SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: child!,
        ),
        child: child!,
      );
    });
  }
}
