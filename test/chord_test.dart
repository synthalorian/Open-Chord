import 'package:flutter_test/flutter_test.dart';
import 'package:open_chord/models/chord.dart';
import 'package:open_chord/data/chord_library.dart';

void main() {
  test('chord library has entries', () {
    expect(chordLibrary.isNotEmpty, true);
  });

  test('chord names format correctly', () {
    final c = Chord(root: NoteName.a, quality: ChordQuality.minor, voicings: []);
    expect(c.name, 'Am');
  });

  test('tunings list has standard first', () {
    expect(tunings.first.name, 'Standard');
    expect(tunings.first.strings.length, 6);
  });

  test('ChordProgression round-trips JSON', () {
    final p = ChordProgression(id: '1', name: 'Test', chordNames: ['Am', 'G', 'C'], createdAt: DateTime(2026));
    final json = p.toJson();
    final restored = ChordProgression.fromJson(json);
    expect(restored.chordNames, ['Am', 'G', 'C']);
  });

  test('all chord voicings have 6 frets', () {
    for (final chord in chordLibrary) {
      for (final v in chord.voicings) {
        expect(v.frets.length, 6, reason: '${chord.name} ${v.name} should have 6 frets');
      }
    }
  });
}
