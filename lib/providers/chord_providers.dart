import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/chord.dart';
import '../data/chord_library.dart';

final selectedRootProvider = StateProvider<NoteName>((ref) => NoteName.c);
final selectedQualityProvider = StateProvider<ChordQuality>((ref) => ChordQuality.major);
final selectedTuningProvider = StateProvider<int>((ref) => 0);
final selectedVoicingIndexProvider = StateProvider<int>((ref) => 0);

final currentChordProvider = Provider<Chord?>((ref) {
  final root = ref.watch(selectedRootProvider);
  final quality = ref.watch(selectedQualityProvider);
  try {
    return chordLibrary.firstWhere((c) => c.root == root && c.quality == quality);
  } catch (_) {
    return null;
  }
});

final currentTuningProvider = Provider<Tuning>((ref) {
  final index = ref.watch(selectedTuningProvider);
  return tunings[index];
});

class ProgressionNotifier extends StateNotifier<List<ChordProgression>> {
  final Box _box;

  ProgressionNotifier(this._box) : super([]) {
    _load();
  }

  void _load() {
    final raw = _box.get('progressions', defaultValue: '[]') as String;
    final list = (jsonDecode(raw) as List)
        .map((e) => ChordProgression.fromJson(e as Map<String, dynamic>))
        .toList();
    state = list;
  }

  void _save() {
    _box.put('progressions', jsonEncode(state.map((p) => p.toJson()).toList()));
  }

  void addProgression(ChordProgression prog) {
    state = [...state, prog];
    _save();
  }

  void deleteProgression(String id) {
    state = state.where((p) => p.id != id).toList();
    _save();
  }

  void addChordToProgression(String progId, String chordName) {
    state = state.map((p) {
      if (p.id == progId) {
        return ChordProgression(
          id: p.id, name: p.name,
          chordNames: [...p.chordNames, chordName],
          createdAt: p.createdAt,
        );
      }
      return p;
    }).toList();
    _save();
  }

  void removeChordFromProgression(String progId, int index) {
    state = state.map((p) {
      if (p.id == progId) {
        final updated = List<String>.from(p.chordNames)..removeAt(index);
        return ChordProgression(
          id: p.id, name: p.name, chordNames: updated, createdAt: p.createdAt,
        );
      }
      return p;
    }).toList();
    _save();
  }
}

final progressionBoxProvider = FutureProvider<Box>((ref) => Hive.openBox('open_chord'));

final progressionProvider = StateNotifierProvider<ProgressionNotifier, List<ChordProgression>>((ref) {
  final boxAsync = ref.watch(progressionBoxProvider);
  return boxAsync.when(
    data: (box) => ProgressionNotifier(box),
    loading: () => ProgressionNotifier(Hive.box('open_chord')),
    error: (_, __) => ProgressionNotifier(Hive.box('open_chord')),
  );
});
