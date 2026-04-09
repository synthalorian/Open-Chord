enum ChordQuality {
  major('Major', ''),
  minor('Minor', 'm'),
  dominant7('Dominant 7', '7'),
  major7('Major 7', 'maj7'),
  minor7('Minor 7', 'm7'),
  diminished('Diminished', 'dim'),
  augmented('Augmented', 'aug'),
  sus2('Suspended 2', 'sus2'),
  sus4('Suspended 4', 'sus4'),
  add9('Add 9', 'add9'),
  power('Power', '5');

  final String displayName;
  final String suffix;
  const ChordQuality(this.displayName, this.suffix);
}

enum NoteName {
  c('C'), cSharp('C#'), d('D'), dSharp('D#'), e('E'), f('F'),
  fSharp('F#'), g('G'), gSharp('G#'), a('A'), aSharp('A#'), b('B');

  final String label;
  const NoteName(this.label);
}

class ChordVoicing {
  final String name;
  final List<int> frets; // -1 = muted, 0 = open, 1+ = fret number
  final int baseFret;

  const ChordVoicing({
    required this.name,
    required this.frets,
    this.baseFret = 1,
  });

  String get displayName => name;
}

class Chord {
  final NoteName root;
  final ChordQuality quality;
  final List<ChordVoicing> voicings;

  const Chord({
    required this.root,
    required this.quality,
    required this.voicings,
  });

  String get name => '${root.label}${quality.suffix}';
}

class Tuning {
  final String name;
  final List<String> strings; // low to high

  const Tuning({required this.name, required this.strings});
}

class ChordProgression {
  final String id;
  final String name;
  final List<String> chordNames;
  final DateTime createdAt;

  ChordProgression({
    required this.id,
    required this.name,
    required this.chordNames,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'chordNames': chordNames,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ChordProgression.fromJson(Map<String, dynamic> json) => ChordProgression(
    id: json['id'] as String,
    name: json['name'] as String,
    chordNames: List<String>.from(json['chordNames'] as List),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}
