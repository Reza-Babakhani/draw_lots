import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  final _random = Random();
  final _player = AudioPlayer();
  int _diceCount = 1;
  List<int> _diceValues = List.filled(1, 6);

  bool _isLoad = true;
  @override
  void didChangeDependencies() async {
    if (_isLoad) {
      await _player.setAsset("assets/audio/dice.mp3");
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
        title: const Text("تاس بریز"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: _diceCount <= 1
                      ? null
                      : () {
                          setState(() {
                            _diceCount--;
                            _diceValues = List.filled(_diceCount, 6);
                          });
                        },
                  icon: const Icon(Icons.exposure_minus_1),
                  iconSize: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton.filledTonal(
                  onPressed: _diceCount >= 9
                      ? null
                      : () async {
                          setState(() {
                            _diceCount++;
                            _diceValues = List.filled(_diceCount, 6);
                          });
                        },
                  icon: const Icon(Icons.exposure_plus_1),
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Center(
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  children: [
                    ...[
                      for (int i = 0; i < _diceCount; i++)
                        Image.asset("assets/images/${_diceValues[i]}.png"),
                    ]
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ]),
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
            _player.seek(Duration.zero);
            _player.play();

            await Future.delayed(const Duration(milliseconds: 100));
            for (int i = 0; i < _diceCount; i++) {
              setState(() {
                _diceValues[i] = _random.nextInt(5) + 1;
              });
            }
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
