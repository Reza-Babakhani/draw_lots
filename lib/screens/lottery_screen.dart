import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({super.key});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  final _textController = TextEditingController();
  final _confettiController = ConfettiController();
  final _player = AudioPlayer();

  final __random = Random();
  int _winner = -1;

  final List<String> _names = List<String>.empty(growable: true);

  bool _isLoad = true;
  @override
  void didChangeDependencies() async {
    if (_isLoad) {
      await _player.setAsset("assets/audio/confetti.mp3");
      await _player.load();
      _isLoad = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title: const Text("قرعه‌کشی"),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    label: const Text("نام"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_textController.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          _names.add(_textController.text);
                          _textController.clear();
                        });
                      },
                      icon: const Icon(Icons.add),
                      color: Theme.of(context).colorScheme.primary,
                      iconSize: 40,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: "برنده: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      if (_winner >= 0)
                        TextSpan(
                          text: _names[_winner],
                        ),
                    ])),
                  )),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  separatorBuilder: (ctx, i) {
                    return const Divider(
                      height: 2,
                    );
                  },
                  itemBuilder: (ctx, i) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: Text(_names[i]),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _winner = -1;
                              _names.removeAt(i);
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    );
                  },
                  itemCount: _names.length,
                  shrinkWrap: true,
                ),
              )
            ]),
          ),
          floatingActionButton: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  foregroundColor: Colors.black,
                  fixedSize: const Size.fromHeight(60)),
              child: const Text(
                "قرعه کشی",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                setState(() {
                  _winner = -1;
                });
                if (_names.isEmpty) {
                  return;
                }

                setState(() {
                  _winner = __random.nextInt(_names.length);
                });
                _player.seek(Duration.zero);
                _player.play();
                _confettiController.play();
                await Future.delayed(const Duration(seconds: 2));
                _confettiController.stop();
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
        )
      ],
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
