import 'package:scale_master_guitar/hardcoded_data/scales/scales_modes/diatonic_major_modes.dart';
import 'package:scale_master_guitar/hardcoded_data/scales/scales_modes/melodic_minor_modes.dart';
import 'package:scale_master_guitar/hardcoded_data/tonic_harmonic_minor_aux_bug.dart';

import 'scales_modes/harmonic_major_modes.dart';
import 'scales_modes/pentatonics.dart';

class Scales {
  static List<String> options = [
    'Diatonic Major',
    'Melodic Minor',
    'Harmonic Minor',
  ];

  static Map data = {
    'Diatonic Major': diatonicMajorModes.keys.toList(),
    'Melodic Minor': melodicMinorModes.keys.toList(),
    'Harmonic Minor': harmonicMinorModes.keys.toList(),
    'Harmonic Major': harmonicMajorModes.keys.toList(),
    'Pentatonics': pentatonics.keys.toList(),
    // 'Octatonics':
    // 'Hexatonics':
  };
}
