import '../models/chord.dart';

final tunings = [
  const Tuning(name: 'Standard', strings: ['E', 'A', 'D', 'G', 'B', 'E']),
  const Tuning(name: 'Drop D', strings: ['D', 'A', 'D', 'G', 'B', 'E']),
  const Tuning(name: 'DADGAD', strings: ['D', 'A', 'D', 'G', 'A', 'D']),
  const Tuning(name: 'Open G', strings: ['D', 'G', 'D', 'G', 'B', 'D']),
  const Tuning(name: 'Open D', strings: ['D', 'A', 'D', 'F#', 'A', 'D']),
  const Tuning(name: 'Half Step Down', strings: ['Eb', 'Ab', 'Db', 'Gb', 'Bb', 'Eb']),
];

final chordLibrary = <Chord>[
  const Chord(root: NoteName.c, quality: ChordQuality.major, voicings: [
    ChordVoicing(name: 'Open C', frets: [-1, 3, 2, 0, 1, 0]),
    ChordVoicing(name: 'Barre 8th', frets: [8, 10, 10, 9, 8, 8], baseFret: 8),
    ChordVoicing(name: 'C/G', frets: [3, 3, 2, 0, 1, 0]),
  ]),
  const Chord(root: NoteName.d, quality: ChordQuality.major, voicings: [
    ChordVoicing(name: 'Open D', frets: [-1, -1, 0, 2, 3, 2]),
    ChordVoicing(name: 'Barre 5th', frets: [-1, 5, 7, 7, 7, 5], baseFret: 5),
    ChordVoicing(name: 'D/F#', frets: [2, -1, 0, 2, 3, 2]),
  ]),
  const Chord(root: NoteName.e, quality: ChordQuality.major, voicings: [
    ChordVoicing(name: 'Open E', frets: [0, 2, 2, 1, 0, 0]),
    ChordVoicing(name: 'Barre 7th', frets: [-1, 7, 9, 9, 9, 7], baseFret: 7),
  ]),
  const Chord(root: NoteName.g, quality: ChordQuality.major, voicings: [
    ChordVoicing(name: 'Open G', frets: [3, 2, 0, 0, 0, 3]),
    ChordVoicing(name: 'Barre 3rd', frets: [3, 5, 5, 4, 3, 3], baseFret: 3),
  ]),
  const Chord(root: NoteName.a, quality: ChordQuality.major, voicings: [
    ChordVoicing(name: 'Open A', frets: [-1, 0, 2, 2, 2, 0]),
    ChordVoicing(name: 'Barre 5th', frets: [5, 7, 7, 6, 5, 5], baseFret: 5),
  ]),
  const Chord(root: NoteName.a, quality: ChordQuality.minor, voicings: [
    ChordVoicing(name: 'Open Am', frets: [-1, 0, 2, 2, 1, 0]),
    ChordVoicing(name: 'Barre 5th', frets: [5, 7, 7, 5, 5, 5], baseFret: 5),
  ]),
  const Chord(root: NoteName.e, quality: ChordQuality.minor, voicings: [
    ChordVoicing(name: 'Open Em', frets: [0, 2, 2, 0, 0, 0]),
    ChordVoicing(name: 'Barre 7th', frets: [-1, 7, 9, 9, 8, 7], baseFret: 7),
  ]),
  const Chord(root: NoteName.d, quality: ChordQuality.minor, voicings: [
    ChordVoicing(name: 'Open Dm', frets: [-1, -1, 0, 2, 3, 1]),
  ]),
  const Chord(root: NoteName.g, quality: ChordQuality.dominant7, voicings: [
    ChordVoicing(name: 'Open G7', frets: [3, 2, 0, 0, 0, 1]),
  ]),
  const Chord(root: NoteName.c, quality: ChordQuality.major7, voicings: [
    ChordVoicing(name: 'Open Cmaj7', frets: [-1, 3, 2, 0, 0, 0]),
  ]),
  const Chord(root: NoteName.a, quality: ChordQuality.minor7, voicings: [
    ChordVoicing(name: 'Open Am7', frets: [-1, 0, 2, 0, 1, 0]),
  ]),
  const Chord(root: NoteName.e, quality: ChordQuality.power, voicings: [
    ChordVoicing(name: 'E5', frets: [0, 2, 2, -1, -1, -1]),
  ]),
  const Chord(root: NoteName.a, quality: ChordQuality.power, voicings: [
    ChordVoicing(name: 'A5', frets: [-1, 0, 2, 2, -1, -1]),
  ]),
  const Chord(root: NoteName.d, quality: ChordQuality.sus2, voicings: [
    ChordVoicing(name: 'Dsus2', frets: [-1, -1, 0, 2, 3, 0]),
  ]),
  const Chord(root: NoteName.a, quality: ChordQuality.sus4, voicings: [
    ChordVoicing(name: 'Asus4', frets: [-1, 0, 2, 2, 3, 0]),
  ]),
];
