import 'package:flutter/material.dart';
import '../models/chord.dart';
import '../theme/chord_theme.dart';

class FretboardWidget extends StatelessWidget {
  final ChordVoicing voicing;
  final int fretCount;

  const FretboardWidget({
    super.key,
    required this.voicing,
    this.fretCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChordTheme.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(voicing.displayName, style: TextStyle(color: ChordTheme.amber, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: _FretboardPainter(
                voicing: voicing,
                fretCount: fretCount,
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          // Fret numbers below
          Text(
            voicing.frets.map((f) => f == -1 ? 'X' : f.toString()).join('  '),
            style: TextStyle(color: ChordTheme.cream, fontFamily: 'monospace', fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _FretboardPainter extends CustomPainter {
  final ChordVoicing voicing;
  final int fretCount;

  _FretboardPainter({required this.voicing, required this.fretCount});

  @override
  void paint(Canvas canvas, Size size) {
    final stringCount = 6;
    final stringSpacing = size.width / (stringCount + 1);
    final fretSpacing = size.height / (fretCount + 1);
    final topMargin = fretSpacing * 0.5;

    // Draw strings
    final stringPaint = Paint()..color = ChordTheme.cream.withAlpha(100)..strokeWidth = 1.2;
    for (int i = 0; i < stringCount; i++) {
      final x = stringSpacing * (i + 1);
      canvas.drawLine(Offset(x, topMargin), Offset(x, size.height - 10), stringPaint);
    }

    // Draw frets
    final fretPaint = Paint()..color = Colors.white24..strokeWidth = 1.5;
    for (int i = 0; i <= fretCount; i++) {
      final y = topMargin + fretSpacing * i;
      canvas.drawLine(Offset(stringSpacing, y), Offset(stringSpacing * stringCount, y), fretPaint);
    }

    // Nut (thick top line)
    if (voicing.baseFret == 1) {
      final nutPaint = Paint()..color = ChordTheme.cream..strokeWidth = 4;
      canvas.drawLine(Offset(stringSpacing, topMargin), Offset(stringSpacing * stringCount, topMargin), nutPaint);
    }

    // Fret markers (dots)
    final markerFrets = [3, 5, 7, 9, 12];
    for (final mf in markerFrets) {
      final adjustedFret = mf - voicing.baseFret + 1;
      if (adjustedFret > 0 && adjustedFret <= fretCount) {
        final y = topMargin + fretSpacing * adjustedFret - fretSpacing / 2;
        final x = size.width / 2;
        canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.white12);
      }
    }

    // Draw finger positions
    for (int i = 0; i < voicing.frets.length && i < stringCount; i++) {
      final fret = voicing.frets[i];
      final x = stringSpacing * (i + 1);

      if (fret == -1) {
        // Muted string - X
        final textPainter = TextPainter(
          text: TextSpan(text: 'X', style: TextStyle(color: Colors.red[300], fontSize: 14)),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, 0));
      } else if (fret == 0) {
        // Open string - O
        canvas.drawCircle(Offset(x, topMargin - 12), 6, Paint()..color = ChordTheme.amber..style = PaintingStyle.stroke..strokeWidth = 2);
      } else {
        // Fretted note
        final adjustedFret = fret - voicing.baseFret + 1;
        if (adjustedFret > 0 && adjustedFret <= fretCount) {
          final y = topMargin + fretSpacing * adjustedFret - fretSpacing / 2;
          canvas.drawCircle(Offset(x, y), 10, Paint()..color = ChordTheme.amber);
        }
      }
    }

    // Base fret indicator
    if (voicing.baseFret > 1) {
      final textPainter = TextPainter(
        text: TextSpan(text: '${voicing.baseFret}fr', style: TextStyle(color: ChordTheme.cream, fontSize: 12)),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(2, topMargin));
    }
  }

  @override
  bool shouldRepaint(covariant _FretboardPainter oldDelegate) =>
      oldDelegate.voicing != voicing;
}
