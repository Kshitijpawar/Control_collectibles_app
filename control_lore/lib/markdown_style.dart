import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

final markdownStyleSheet = MarkdownStyleSheet(
  h1: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w800,
    fontSize: 26.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  h2: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w700,
    fontSize: 22.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  h3: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  p: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  strong: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  em: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Color.fromARGB(255, 231, 0, 13),
    fontStyle: FontStyle.italic,
  ),
  blockquote: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
  listBullet: TextStyle(
    fontFamily: 'ITCAvantGardeStd-Demi',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Color.fromARGB(255, 231, 0, 13),
  ),
);
