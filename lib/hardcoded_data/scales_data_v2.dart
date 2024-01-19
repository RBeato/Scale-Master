import 'package:tonic/tonic.dart';

List<String> scalesOptions = [
  'Diatonic Major',
  'Melodic Minor',
  'Harmonic Minor',
];

Map scalesData = {
  'Diatonic Major': {
    'scaleStepsRoman': [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
    ],
    'triad': [
      Interval.P1,
      Interval.M3,
      Interval.P5,
    ],
    'tetrade': [
      Interval.P1,
      Interval.M3,
      Interval.P5,
      Interval.M7,
    ],
    'intervals': [0, 2, 4, 5, 7, 9, 11],
    'modeNames': [
      'Ionian',
      'Dorian',
      'Phrygian',
      'Lydian',
      'Mixolydian',
      'Aeolian',
      'Locrian'
    ],
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.M3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.M7
    ],
    'secondaryDominants': {
      'scaleSteps': [
        Interval.P5,
        Interval.M6,
        Interval.M7,
        Interval.P1,
        Interval.M2,
        Interval.M3,
      ],
      'function': ['V', 'V', 'V', 'V', 'V', 'V'],
      'functionRecipients': ['I', 'ii', 'iii', 'IV', 'V', 'vi'],
      'originKey': [7, 7, 7, 7, 7, 7], //relative to the major scale used
      'originModeType': [
        'Ionian',
        'Phrygian Dominant',
        'Phrygian Dominant',
        'Ionian',
        'Ionian',
        'Phrygian Dominant'
      ],
      'chordType': ['7', '7', '7', '7', '7', '7'],
    },
    'mainChords': {
      'scaleSteps': [
        Interval.P1,
        Interval.M2,
        Interval.M3,
        Interval.P4,
        Interval.P5,
        Interval.M6,
      ],
      'function': ['I', 'ii', 'iii', 'IV', 'V', 'vi'],
      'functionRecipients': ['', '', '', '', '', ''],
      'chordType': ['M', 'm', 'm', 'M', 'M', 'm'],
      'originKey': [0, 2, 4, 5, 7, 9], //relative to the major scale used
      'originModeType': [
        'Ionian',
        'Dorian',
        'Phrygian',
        'Lydian',
        'Mixolydian',
        'Aeolian',
      ],
    },
    'modalInterchange': {
      'scaleSteps': [
        Interval.m3,
        Interval.P4,
        Interval.m6,
        Interval.m7,
      ],
      'function': ['♭III', 'iv', '♭VI', '♭VII'],
      'functionRecipients': ['', '', '', '', '', ''],
      'chordType': ['M', 'm', 'M', 'M'],
      'originKey': [5, 8, 0, 0], //relative to the major scale used
      'originModeType': [
        'Lydian',
        'Dorian',
        'Ionian',
        'Ionian',
      ],
    },
  },
  'Melodic Minor': {
    'scaleStepsRoman': [
      'I',
      'II',
      '♭III',
      'IV',
      'V',
      'VI',
      'VII',
    ],
    'triad': [
      Interval.P1,
      Interval.m3,
      Interval.P5,
    ],
    'tetrade': [
      Interval.P1,
      Interval.m3,
      Interval.P5,
      Interval.M7,
    ],
    'intervals': [0, 2, 3, 5, 7, 9, 11],
    'modeNames': [
      'Jazz Minor',
      'Dorian ♭2',
      'Lydian Augmented',
      'Lydian Dominant',
      'Mixolydian ♭6',
      'Semilocrian',
      'Superlocrian'
    ],
    //Change information
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.M6,
      Interval.M7
    ],

    'secondaryDominants': {
      'scaleSteps': [
        Interval.P5,
        Interval.m3,
        Interval.P1,
        Interval.M6,
        Interval.M2,
        Interval.M7
      ],
      'function': ['V', 'V', 'V', 'V', 'V', 'V'],
      'functionRecipients': ['I', 'vi', 'IV', 'ii', 'V', 'iii'],
      'chordType': ['7', '7', '7', '7', '7', '7'],
    },
    'mainChords': {
      'scaleSteps': [
        Interval.P1,
        Interval.M6,
        Interval.P4,
        Interval.M2,
        Interval.P5,
        Interval.m3
      ],
      'function': ['I', 'vi', 'IV', 'ii', 'V', 'iii'],
      'functionRecipients': ['', '', '', '', '', ''],
      'chordType': ['M', 'm', 'M', 'm', 'M', 'm'],
    },
    'modalInterchange': {
      'scaleSteps': [
        Interval.m3,
        Interval.m6,
        Interval.P4,
        Interval.m7,
      ],
      'function': ['♭III', '♭VI', 'iv', '♭VII'],
      'functionRecipients': ['', '', '', '', '', ''],
      'chordType': ['M', 'M', 'm', 'M'],
    },
  },
  'Harmonic Minor': {
    'scaleStepsRoman': [
      'I',
      'II',
      '♭III',
      'IV',
      'V',
      '♭VI',
      'VII',
    ],
    'triad': [
      Interval.P1,
      Interval.m3,
      Interval.P5,
    ],
    'tetrade': [
      Interval.P1,
      Interval.m3,
      Interval.P5,
      Interval.M7,
    ],
    'intervals': [0, 2, 3, 5, 7, 8, 11],
    'modeNames': [
      'Harmonic Minor',
      'Locrian ♯6',
      'Ionian Augmented',
      'Romanian',
      'Phrygian Dominant',
      'Lydian ♯2',
      'Ultralocrian'
    ],
    //Change information
    'scaleDegrees': [
      Interval.P1,
      Interval.M2,
      Interval.m3,
      Interval.P4,
      Interval.P5,
      Interval.m6,
      Interval.M7
    ],
    'secondaryDiminished_v': {
      'scaleSteps': [
        Interval.A4,
        Interval.M6,
        Interval.P1,
        Interval.m3,
        Interval.m2,
      ],
      'function': ['iv', 'vi', 'i', 'iii', 'ii'],
      'functionRecipients': ['V', 'V', 'V', 'V', 'V'],
      'originKey': [6, 9, 0, 3, 1], //relative to the harmonic scale used
      'originModeType': [
        'Ultralocrian',
        'Ultralocrian',
        'Ultralocrian',
        'Ultralocrian',
        'Ionian'
      ],
      'chordType': ['°', '°', '°', '°', 'M'],
    },
    // 'secondaryDiminished_v': {
    //   'scaleSteps': [
    //     Interval.P1,
    //     Interval.m2,
    //     Interval.m3,
    //     Interval.A4,
    //     Interval.M6,
    //   ],
    //   'function': ['i', 'ii', 'iii', 'iv', 'vi'],
    //   'functionRecipients': ['V', 'V', 'V', 'V', 'V'],
    //   'originKey': [0, 1, 3, 6, 9], //relative to the harmonic scale used
    //   'originModeType': [
    //     'Ultralocrian',
    //     'Ionian'
    //         'Ultralocrian',
    //     'Ultralocrian',
    //     'Ultralocrian',
    //   ],
    //   'chordType': ['°', 'M', '°', '°', '°'],
    // },
    'mainChords': {
      'scaleSteps': [
        Interval.P1,
        Interval.M2,
        Interval.m3,
        Interval.P4,
        Interval.P5,
        Interval.m6,
        Interval.M7,
      ],
      'function': ['I', 'ii', '♭III', 'iv', 'V', '♭VI', 'vii'],
      'functionRecipients': ['', '', '', '', '', '', ''],
      'chordType': ['m', '°', '+', 'm', '7', 'M', '°'],
      'originKey': [
        0,
        3,
        9,
        5,
        7,
        2,
        4,
      ], //relative to the major scale used
      'originModeType': [
        'Harmonic Minor',
        'Locrian ♯6',
        'Ionian Augmented',
        'Romanian',
        'Phrygian Dominant',
        'Lydian ♯2',
        'Ultralocrian',
      ],
    },
    'secondaryDiminished_iv': {
      'scaleSteps': [
        Interval.m2,
        Interval.M3,
        Interval.P5,
        Interval.m7,
      ],
      'function': ['♭ii', 'iii', 'v', '♭vii'],
      'functionRecipients': ['', '', '', ''],
      'chordType': ['°', '°', '°', '°'],
      'originKey': [1, 4, 7, 10],
      //relative to the Harmonic minor scale used
      'originModeType': [
        'Ultralocrian',
        'Ultralocrian',
        'Ultralocrian',
        'Ultralocrian',
      ],
    },
  }
};
