import 'package:card_dashboard/widgets/cards/dashboard_card_data.dart';
import 'package:card_dashboard/widgets/dashboard/dashboard_grid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool editMode = false;

  List<DashboardCardData> cards = [
    DashboardCardData(
      backgroundColor: Colors.amber,
      child: Container(
        color: Colors.grey,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cards.add(DashboardCardData(
                        backgroundColor: Colors.amber,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ));
                    });
                  },
                  child: const Text('add card'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      editMode = !editMode;
                    });
                  },
                  child: Text(editMode ? 'View' : 'Edit'),
                ),
              ],
            ),
          ),
          DashboardGrid(
            editMode: editMode,
            cards: cards,
            onCardListChanged: (newCards) {
              setState(() {
                cards = newCards;
              });
            },
          ),
        ],
      ),
    );
  }
}
