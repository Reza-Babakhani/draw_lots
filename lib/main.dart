import 'package:draw_lots/screens/dice_screen.dart';
import 'package:draw_lots/screens/flip_a_coin_screen.dart';
import 'package:draw_lots/screens/lottery_screen.dart';
import 'package:draw_lots/screens/range_screen.dart';
import 'package:draw_lots/screens/rps_screen.dart';
import 'package:draw_lots/screens/yes_no_screen.dart';
import 'package:flutter/material.dart';
import 'package:adivery/adivery.dart';

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
  String adId = "951de443-da8b-410e-a537-7ec818fabdfd";

  @override
  void initState() {
    super.initState();

    AdiveryPlugin.initialize("aa5acf60-550b-49af-96c3-44283df12e85");
    AdiveryPlugin.prepareRewardedAd(adId);
  }

  Future<void> ad() async {
    AdiveryPlugin.prepareRewardedAd(adId);
   
    AdiveryPlugin.isLoaded(adId)
        .then((isLoaded) => showPlacement(isLoaded!, adId));
  }

  void showPlacement(bool isLoaded, String placementId) {
    if (isLoaded) {
      AdiveryPlugin.show(placementId);
    }
  }

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
          ItemCard("تاس بریز", "assets/images/dice-64.png", () {
            ad();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const DiceScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
          ItemCard("شیر یا خط", "assets/images/coin-toss-64.png", () {
            ad();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const FlipACoinScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
          ItemCard("سنگ، کاغذ، قیچی", "assets/images/rps-64.png", () {
            ad();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const RPSScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
          ItemCard("قرعه‌کشی", "assets/images/raffle-64.png", () {
            ad();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const LotteryScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
          ItemCard("عدد تصادفی", "assets/images/lottery-64.png", () {
            ad();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const RangeScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
          ItemCard("بله/خیر", "assets/images/yesno-64.png", () {
            ad();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const YesNoScreen()));
            AdiveryPlugin.prepareRewardedAd(adId);
          }),
        ],
      ),
    );
  }
}
