import 'package:card_dashboard/card_dashboard.dart';
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
  List<DashboardDraggableCard> cards = [
    DashboardDraggableCard(
      x: 2,
      y: 3,
      child: Container(
        color: Colors.blue,
      ),
    ),
    DashboardDraggableCard(
      x: 3,
      y: 1,
      child: Container(
        color: Colors.amber,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CardDashboard(
        children: cards,
        onChanged: (value) {
          setState(() {
            cards = value;
          });
        },
      ),
    );
  }
}
