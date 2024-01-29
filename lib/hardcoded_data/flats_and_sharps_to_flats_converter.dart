flatsAndSharpsToFlats(noteSubString) {
  // print('Called flatsOnlyNoteNomenclature');
  switch (noteSubString) {
    case 'C':
      noteSubString = 'C';
      break;
    case 'C♯/D♭':
      noteSubString = 'D♭';
      break;
    case 'D':
      noteSubString = 'D';
      break;
    case 'D♯/E♭':
      noteSubString = 'E♭';
      break;
    case 'E':
      noteSubString = 'E';
      break;
    case 'F':
      noteSubString = 'F';
      break;
    case 'F♯/G♭':
      noteSubString = 'G♭';
      break;
    case 'G':
      noteSubString = 'G';
      break;
    case 'G♯/A♭':
      noteSubString = 'A♭';
      break;
    case 'A':
      noteSubString = 'A';
      break;
    case 'A♯/B♭':
      noteSubString = 'B♭';
      break;
    case 'B':
      noteSubString = 'B';
      break;
  }

  return noteSubString;
}
