import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chord.dart';
import '../providers/chord_providers.dart';
import '../data/chord_library.dart';
import '../widgets/fretboard_widget.dart';
import '../theme/chord_theme.dart';

class ExplorerScreen extends ConsumerWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Open', style: TextStyle(color: ChordTheme.amber)),
            const Text('Chord'),
          ],
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: _ExplorerBody(),
        ),
      ),
    );
  }
}

class _ExplorerBody extends ConsumerWidget {
  const _ExplorerBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final root = ref.watch(selectedRootProvider);
    final quality = ref.watch(selectedQualityProvider);
    final chord = ref.watch(currentChordProvider);
    final voicingIdx = ref.watch(selectedVoicingIndexProvider);
    final tuning = ref.watch(currentTuningProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tuning selector
        Row(
          children: [
            Text('Tuning: ', style: TextStyle(color: ChordTheme.cream)),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tunings.asMap().entries.map((e) {
                    final selected = ref.read(selectedTuningProvider) == e.key;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(e.value.name),
                        selected: selected,
                        selectedColor: ChordTheme.amber,
                        backgroundColor: ChordTheme.card,
                        labelStyle: TextStyle(color: selected ? Colors.black : ChordTheme.cream),
                        onSelected: (_) => ref.read(selectedTuningProvider.notifier).state = e.key,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Strings: ${tuning.strings.join(" ")}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
        const SizedBox(height: 16),
        // Root note selector
        Text('Root Note', style: TextStyle(color: ChordTheme.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: NoteName.values.map((n) {
            final selected = n == root;
            return GestureDetector(
              onTap: () {
                ref.read(selectedRootProvider.notifier).state = n;
                ref.read(selectedVoicingIndexProvider.notifier).state = 0;
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: selected ? ChordTheme.amber : ChordTheme.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: selected ? ChordTheme.amber : ChordTheme.surface),
                ),
                alignment: Alignment.center,
                child: Text(n.label, style: TextStyle(
                  color: selected ? Colors.black : ChordTheme.cream,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Quality selector
        Text('Quality', style: TextStyle(color: ChordTheme.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ChordQuality.values.map((q) {
            final selected = q == quality;
            return GestureDetector(
              onTap: () {
                ref.read(selectedQualityProvider.notifier).state = q;
                ref.read(selectedVoicingIndexProvider.notifier).state = 0;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? ChordTheme.orange : ChordTheme.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(q.displayName, style: TextStyle(
                  color: selected ? Colors.black : ChordTheme.cream,
                  fontSize: 13,
                )),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        // Fretboard display
        if (chord != null) ...[
          Text(chord.name, style: TextStyle(color: ChordTheme.amber, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (chord.voicings.length > 1)
            Row(
              children: chord.voicings.asMap().entries.map((e) {
                final selected = e.key == voicingIdx;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => ref.read(selectedVoicingIndexProvider.notifier).state = e.key,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? ChordTheme.amber.withAlpha(40) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: selected ? ChordTheme.amber : ChordTheme.surface),
                      ),
                      child: Text('${e.key + 1}', style: TextStyle(color: selected ? ChordTheme.amber : Colors.white54)),
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 12),
          FretboardWidget(
            voicing: chord.voicings[voicingIdx.clamp(0, chord.voicings.length - 1)],
          ),
        ] else
          Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            child: Text(
              'No voicings for ${root.label}${quality.suffix} yet',
              style: const TextStyle(color: Colors.white38),
            ),
          ),
      ],
    );
  }
}
