import 'package:flutter/material.dart';

final baseTextStyle = const TextStyle(fontFamily: 'Avenir');

final headerTextStyle = baseTextStyle.copyWith(
  color: Colors.black87,
  fontSize: 20,
  fontWeight: FontWeight.w600
);

final regularTextStyle = baseTextStyle.copyWith(
  color: Color(0xffb6b2df),
  fontSize: 14,
  fontWeight: FontWeight.w400
);

final subHeaderTextStyle = regularTextStyle.copyWith(
  fontSize: 12
);

final detailTextStyle = regularTextStyle.copyWith(
  color: Color(0xffb6b2df),
  fontSize: 16
);