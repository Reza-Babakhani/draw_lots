import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RPSScreen extends StatefulWidget {
  const RPSScreen({super.key});

  @override
  State<RPSScreen> createState() => _RPSScreenState();
}

class _RPSScreenState extends State<RPSScreen> {
  final random = Random();
  int _rps = 0; //0,1,2 rock,paper,scissors
  final _player = AudioPlayer();

  double _height = 100;
  @override
  void initState() {
    _player.setAsset("assets/audio/clap1.wav", preload: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("سنگ، کاغذ، قیچی"),
      ),
      body: Center(
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          height: _height,
          duration: const Duration(milliseconds: 100),
          child: Image(
            image: AssetImage("assets/images/rps-$_rps.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Text(
            "برو",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            setState(() {
              _rps = 0;
            });

            for (int i = 0; i < 3; i++) {
              await Future.delayed(const Duration(milliseconds: 100));

              setState(() {
                _height = 150;
              });
              await _player.seek(Duration.zero);
              await _player.play();
              setState(() {
                _height = 100;
              });
            }
            setState(() {
              _rps = random.nextInt(3);
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
