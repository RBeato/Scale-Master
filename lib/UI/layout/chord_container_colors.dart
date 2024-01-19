import 'package:flutter/material.dart';
import 'package:tonic/tonic.dart' as tonic;

const Color yellowGreen = Color(0xFF33cc33);
const Color scarlet = Color(0xFFcc3300); //
const Color blueGreen = Color(0xFF00cccc);
const Color orange = Color(0xFFff9933);
const Color blue = Color(0xFF1a53ff);
const Color lemonYellow = Color(0xFFf4ec6b);
const Color violet = Color(0xFF800080);
const Color green = Color(0xFF006600);
const Color red = Color(0xFFff3300);
const Color lightBlue = Color(0xFF33ccff);
const Color yellow = Color(0xFFffcc00);
const Color blueViolet = Color(0xFF6600ff);

Map scaleColorMap = {
  'I': green,
  'II': lemonYellow,
  'III': orange,
  'IV': blueGreen,
  'V': yellowGreen,
  'VI': yellow,
  'VII': red,
  '♭II': violet,
  '♭III': blue,
  '♭VI': blueViolet,
  '♭VII': lightBlue,
  '♭V': scarlet,
};

Map<tonic.Interval, Color> scaleTonicColorMap = {
  tonic.Interval.P1: green,
  tonic.Interval.m2: violet,
  tonic.Interval.M2: lemonYellow,
  tonic.Interval.M3: orange,
  tonic.Interval.m3: blue,
  tonic.Interval.P4: blueGreen,
  tonic.Interval.A4: scarlet,
  tonic.Interval.d5: scarlet,
  tonic.Interval.P5: yellowGreen,
  tonic.Interval.m6: blueViolet,
  tonic.Interval.M6: yellow,
  tonic.Interval.m7: lightBlue,
  tonic.Interval.M7: red,
};
