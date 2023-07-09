import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class FlipACoinScreen extends StatefulWidget {
  const FlipACoinScreen({super.key});

  @override
  State<FlipACoinScreen> createState() => _FlipACoinScreenState();
}

class _FlipACoinScreenState extends State<FlipACoinScreen> {
  final random = Random();

  late FlipCardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("شیر یا خط"),
      ),
      body: Center(
        child: FlipCard(
          controller: _controller,
          fill: Fill.fillFront,
          side: CardSide.FRONT,
          flipOnTouch: false,
          speed: 100,
          front: const Image(
            image: AssetImage("assets/images/coin.png"),
            height: 180,
          ),
          back: const Image(
            image: AssetImage("assets/images/dollar.png"),
            height: 180,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text(
            "بریز",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            for (int i = 0; i < 30; i++) {
              await Future.delayed(const Duration(milliseconds: 50));
              await _controller.toggleCard();
            }
            if (random.nextBool()) {
              await Future.delayed(const Duration(milliseconds: 50));
              await _controller.toggleCard();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
