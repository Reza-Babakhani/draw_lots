import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RangeScreen extends StatefulWidget {
  const RangeScreen({super.key});

  @override
  State<RangeScreen> createState() => _RangeScreenState();
}

class _RangeScreenState extends State<RangeScreen> {
  final __random = Random();
  final _player = AudioPlayer();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  int _result = -1;
  bool _spinning = false;
  bool _error = false;
  @override
  void initState() {
    _fromController.text = "1";
    _toController.text = "100";

    super.initState();
  }

  bool _isLoad = true;
  @override
  void didChangeDependencies() async {
    if (_isLoad) {
      await _player.setAsset("assets/audio/lottery.mp3");
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
        title: const Text("عدد تصادفی"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      label: Text("تا عدد"),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      label: Text("از عدد"),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          _error
              ? const Text(
                  "اعداد انتخابی معتبر نیستند",
                  style: TextStyle(color: Colors.red),
                )
              : Center(
                  child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _spinning
                        ? const CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage("assets/images/lottery.gif"),
                          )
                        : Container(),
                    _result < 0
                        ? Container()
                        : CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: Text(
                              "$_result",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                )),
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
          onPressed: () {
            setState(() {
              _error = false;
              _result = -1;
            });
            int from = int.parse(_fromController.text);
            int to = int.parse(_toController.text);

            if (from >= to) {
              setState(() {
                _error = true;
              });

              return;
            }

            setState(() {
              _spinning = true;
            });

            _player.seek(Duration.zero);
            _player.play();

            Future.delayed(const Duration(seconds: 5)).whenComplete(() {
              setState(() {
                _result = __random.nextInt(to - from) + from;
                _spinning = false;
              });
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
