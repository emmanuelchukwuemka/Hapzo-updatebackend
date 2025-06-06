export 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.decoration,
      required this.text,
      this.maxLines,
      this.softWrap = true,
   
      this.textAlign,
      this.overflow,
      });
  final Color? color;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final bool softWrap ;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style:   GoogleFonts.itim(
                color: color ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.w400,
                fontSize: fontSize?.sp ?? 14.sp,
                height: 0,
                decoration: decoration,
                decorationColor:
                    color ?? Theme.of(context).textTheme.bodyLarge!.color))
            ;
  }
}
