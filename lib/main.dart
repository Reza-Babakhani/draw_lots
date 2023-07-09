import 'package:draw_lots/screens/flip_a_coin_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/item_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'یا بخت و یا اقبال',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: "Tanha"),
      home: const MyHomePage(title: 'یا بخت و یا اقبال'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        children: [
          ItemCard("تاس بریز", "assets/images/dice-64.png", () {}),
          ItemCard("شیر یا خط", "assets/images/coin-toss-64.png", () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const FlipACoinScreen()));
          }),
          ItemCard("سنگ، کاغذ، قیچی", "assets/images/rps-64.png", () {}),
          ItemCard("قرعه کشی", "assets/images/raffle-64.png", () {}),
          ItemCard("عدد تصادفی", "assets/images/lottery-64.png", () {}),
          ItemCard("بله/خیر", "assets/images/yesno-64.png", () {}),
        ],
      ),
    );
  }
}
