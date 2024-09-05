import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;

  TextOverflow textOverflow;
  final int? maxLines;
  final bool? bold;

  KText({
    super.key,
    required this.text,
    this.color,
    this.bold = false,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textScaler: const TextScaler.linear(1.0),
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: fontSize != null ? fontSize! : 14,
        fontFamily: bold! ? 'Roboto Bold' : 'Roboto Regular',
        color: color ?? Colors.black,
      ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
