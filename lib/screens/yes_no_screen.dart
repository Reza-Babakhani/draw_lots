import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class YesNoScreen extends StatefulWidget {
  const YesNoScreen({super.key});

  @override
  State<YesNoScreen> createState() => _YesNoScreenState();
}

class _YesNoScreenState extends State<YesNoScreen> {
  final _random = Random();
  bool _yes = false;
  bool _show = false;
  final _player = AudioPlayer();

  double _height = 100;

  bool _isLoad = true;
  @override
  void didChangeDependencies() async {
    if (_isLoad) {
      await _player.setAsset("assets/audio/slap.wav");
      await _player.load();

      _isLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("بله/خیر"),
      ),
      body: _show
          ? Center(
              child: AnimatedContainer(
                curve: Curves.easeInOut,
                height: _height,
                duration: const Duration(milliseconds: 100),
                child: Image(
                  image: _yes
                      ? const AssetImage("assets/images/yes-fa-64.png")
                      : const AssetImage("assets/images/no-fa-64.png"),
                  fit: BoxFit.contain,
                ),
              ),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
          child: const Text(
            "بله؟",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            setState(() {
              _show = false;
            });

            await Future.delayed(const Duration(milliseconds: 200));
            setState(() {
              _show = true;
              _yes = _random.nextBool();
              _height = 150;
            });

            await Future.delayed(const Duration(milliseconds: 100));
            await _player.seek(Duration.zero);
            await _player.play();
            setState(() {
              _height = 100;
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
