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
    const stringCount = 6;
    final stringSpacing = size.width / (stringCount + 1);
    final fretSpacing = size.height / (fretCount + 1);
    final topMargin = fretSpacing * 0.5;

    // Background Grid Glow
    final gridGlowPaint = Paint()
      ..color = ChordTheme.purple.withAlpha(30)
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw strings
    final stringPaint = Paint()..color = ChordTheme.cyan.withAlpha(100)..strokeWidth = 1.2;
    for (int i = 0; i < stringCount; i++) {
      final x = stringSpacing * (i + 1);
      canvas.drawLine(Offset(x, topMargin), Offset(x, size.height - 10), gridGlowPaint);
      canvas.drawLine(Offset(x, topMargin), Offset(x, size.height - 10), stringPaint);
    }

    // Draw frets
    final fretPaint = Paint()..color = ChordTheme.purple.withAlpha(80)..strokeWidth = 1.5;
    for (int i = 0; i <= fretCount; i++) {
      final y = topMargin + fretSpacing * i;
      canvas.drawLine(Offset(stringSpacing, y), Offset(stringSpacing * stringCount, y), gridGlowPaint);
      canvas.drawLine(Offset(stringSpacing, y), Offset(stringSpacing * stringCount, y), fretPaint);
    }

    // Nut (thick top line)
    if (voicing.baseFret == 1) {
      final nutPaint = Paint()..color = ChordTheme.cyan..strokeWidth = 4;
      final nutGlow = Paint()
        ..color = ChordTheme.cyan.withAlpha(100)
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawLine(Offset(stringSpacing, topMargin), Offset(stringSpacing * stringCount, topMargin), nutGlow);
      canvas.drawLine(Offset(stringSpacing, topMargin), Offset(stringSpacing * stringCount, topMargin), nutPaint);
    }

    // Fret markers (dots)
    final markerFrets = [3, 5, 7, 9, 12];
    for (final mf in markerFrets) {
      final adjustedFret = mf - voicing.baseFret + 1;
      if (adjustedFret > 0 && adjustedFret <= fretCount) {
        final y = topMargin + fretSpacing * adjustedFret - fretSpacing / 2;
        final x = (stringSpacing * 3.5); // Center of fretboard
        canvas.drawCircle(Offset(x, y), 3, Paint()..color = ChordTheme.purple.withAlpha(60));
      }
    }

    // Draw finger positions
    for (int i = 0; i < voicing.frets.length && i < stringCount; i++) {
      final fret = voicing.frets[i];
      final x = stringSpacing * (i + 1);

      if (fret == -1) {
        // Muted string - X
        final textPainter = TextPainter(
          text: const TextSpan(text: '✕', style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, -4));
      } else if (fret == 0) {
        // Open string - O
        final openPaint = Paint()..color = ChordTheme.pink..style = PaintingStyle.stroke..strokeWidth = 2.5;
        final openGlow = Paint()
          ..color = ChordTheme.pink.withAlpha(100)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
        
        canvas.drawCircle(Offset(x, topMargin - 14), 7, openGlow);
        canvas.drawCircle(Offset(x, topMargin - 14), 7, openPaint);
      } else {
        // Fretted note
        final adjustedFret = fret - voicing.baseFret + 1;
        if (adjustedFret > 0 && adjustedFret <= fretCount) {
          final y = topMargin + fretSpacing * adjustedFret - fretSpacing / 2;
          
          final notePaint = Paint()..color = ChordTheme.pink;
          final noteGlow = Paint()
            ..color = ChordTheme.pink.withAlpha(150)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
          
          canvas.drawCircle(Offset(x, y), 12, noteGlow);
          canvas.drawCircle(Offset(x, y), 10, notePaint);
          
          // Inner highlight
          canvas.drawCircle(Offset(x - 2, y - 2), 3, Paint()..color = Colors.white.withAlpha(180));
        }
      }
    }

    // Base fret indicator
    if (voicing.baseFret > 1) {
      final textPainter = TextPainter(
        text: TextSpan(text: '${voicing.baseFret}fr', style: TextStyle(color: ChordTheme.cyan, fontSize: 13, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(stringSpacing * 0.2, topMargin + 10));
    }
  }

  @override
  bool shouldRepaint(covariant _FretboardPainter oldDelegate) =>
      oldDelegate.voicing != voicing;
}
