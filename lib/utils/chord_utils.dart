import 'package:tonic/tonic.dart';

class ChordUtils {
  static String handleCustomPatterns(List<Interval?> intervals) {
    List<String> intervalNames = intervals.map((interval) {
      if (interval == Interval.P1) {
        return 'P1';
      } else if (interval == Interval.m2) {
        return 'm2';
      } else if (interval == Interval.M2) {
        return 'M2';
      } else if (interval == Interval.d3) {
        return 'd3';
      } else if (interval == Interval.m3) {
        return 'm3';
      } else if (interval == Interval.M3) {
        return 'M3';
      } else if (interval == Interval.P4) {
        return 'P4';
      } else if (interval == Interval.A4) {
        return 'A4';
      } else if (interval == Interval.d5) {
        return 'd5';
      } else if (interval == Interval.P5) {
        return 'P5';
      } else if (interval == Interval.A5) {
        return 'A5';
      } else if (interval == Interval.m6) {
        return 'm6';
      } else if (interval == Interval.M6) {
        return 'M6';
      } else if (interval == Interval.m7) {
        return 'm7';
      } else if (interval == Interval.M7) {
        return 'M7';
      } else {
        return '';
      }
    }).toList();

    // Join interval names to form a chord pattern string
    String chordPattern = intervalNames.join(',');

    // Manually handle chord patterns not recognized by the ChordPattern class

    if (chordPattern == 'P1,m3,m6') {
      //*inversion
      return 'M7/5'; // Minor chord
    }
    if (chordPattern == 'P1,m3,m7') {
      return 'm7'; // Minor chord
    }
    if (chordPattern == 'P1,M3,m7') {
      return '7'; // Minor chord
    }
    if (chordPattern == 'P1,d3,m6') {
      return 'mMaj7'; // Minor chord
    }
    if (chordPattern == 'P1,m3,M6') {
      return 'dim/3'; // Minor chord
    }
    if (chordPattern == 'P1,P4,M6') {
      //*inversion
      return 'M64'; // Minor chord
    }
    if (chordPattern == 'P1,M3,M6') {
      return 'm6'; // Minor chord
    }
    if (chordPattern == 'P1,P4,m6') {
      //*inversion
      return 'm64'; // Minor chord
    }

    if (chordPattern == 'P1,P4,m7') {
      //*inversion
      return 'sus4/2'; // Minor chord
    }
    if (chordPattern == 'P1,P4,M7') {
      return '1/4/7'; // Minor chord
    }
    if (chordPattern == 'P1,A4,M6') {
      //*inversion
      return '7/5/3'; // Minor chord
    }
    if (chordPattern == 'P1,A4,m6') {
      //*inversion
      return "7/3"; // Minor chord
    }
    if (chordPattern == 'P1,A4,M6') {
      //*inversion
      return 'dim/4'; // Minor chord
    }
    if (chordPattern == 'P1,A4,M7') {
      return 'Maj7#11'; // Minor chord
    }
    if (chordPattern == 'P1,m3,M7') {
      return 'mMaj7'; // Minor chord
    }
    if (chordPattern == 'P1,d5,m7') {
      return 'ø7'; // Minor chord
    }
    if (chordPattern == 'P1,A5,M7') {
      return 'aug Maj7'; // Minor chord
    } else {
      return 'UNKNOWN';
    }
  }
}
