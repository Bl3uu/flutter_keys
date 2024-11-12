import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'PianoProvider.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => PianoProvider(),
      child:  const PianoApp(),
    )
);



Expanded whiteKeys(int A){
  return Expanded(
    child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: (){
          final player = AudioPlayer();
          player.play(AssetSource('note$A.wav'));
        },
        child: Container(
        )
    ),
  );
}

Positioned blackKey(int A, double topPosition) {
  return Positioned(
    top: topPosition,
    right: 0,
    child: SizedBox(
      width: 250,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: () {
          final player = AudioPlayer();
          player.play(AssetSource('note$A.wav'));
        },
        child: Container(),
      ),
    ),
  );
}

class PianoApp extends StatelessWidget {
  const PianoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pianoProvider = Provider.of<PianoProvider>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Consumer<PianoProvider>(
            builder: (context, pianoProvider, child) {
              return Text('Piano - Octave ${pianoProvider.octave}');
            },
          ),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: (){
                pianoProvider.previousOctave();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: (){
                pianoProvider.nextOctave();
              },
            )
          ],
        ),
        body: SafeArea(
          child: Consumer<PianoProvider>(
            builder: (context, pianoProvider, child) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      whiteKeys(pianoProvider.getNoteForKey(1)),
                      whiteKeys(pianoProvider.getNoteForKey(3)),
                      whiteKeys(pianoProvider.getNoteForKey(5)),
                      whiteKeys(pianoProvider.getNoteForKey(6)),
                      whiteKeys(pianoProvider.getNoteForKey(8)),
                      whiteKeys(pianoProvider.getNoteForKey(10)),
                      whiteKeys(pianoProvider.getNoteForKey(12)),
                    ],
                  ),
                  blackKey(pianoProvider.getNoteForKey(2), 55),
                  blackKey(pianoProvider.getNoteForKey(4), 145),
                  blackKey(pianoProvider.getNoteForKey(7), 310),
                  blackKey(pianoProvider.getNoteForKey(9), 400),
                  blackKey(pianoProvider.getNoteForKey(11), 490)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}