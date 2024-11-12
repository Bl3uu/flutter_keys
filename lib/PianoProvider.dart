import 'package:flutter/material.dart';

class PianoProvider with ChangeNotifier {
  int _octave = 1;

  int get octave => _octave;


  void nextOctave() {
    if (_octave < 4) {
      _octave++;
      notifyListeners();
    }
  }

  void previousOctave() {
    if (_octave > 1) {
      _octave--;
      notifyListeners();
    }
  }

  int getNoteForKey(int key) {
    return (key + (_octave - 1) * 12);
  }
}