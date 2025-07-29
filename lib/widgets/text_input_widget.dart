import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haptext_api/widgets/app_text.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      this.title,
      this.hintText,
      this.suffix,
      this.prefix,
      this.onTap,
      this.isReadOnly = false,
      this.controller,
      this.verticalSpace,
      this.contentPadding,
      this.keyboardType,
      this.validator,
      this.inputFormatters,
      this.onChanged,
      this.isPassword = false,
      this.isFilled = false,
      this.fillColor,
      this.hintTextColor,
      this.hintFontSize,
      this.onEditingComplete,
      this.enabled = true,
      this.maxLines});

  final String? title;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefix;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  final double? verticalSpace;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final bool isPassword;
  final bool isFilled;
  final int? maxLines;
  final Color? fillColor;
  final Color? hintTextColor;
  final double? hintFontSize;
  final void Function()? onEditingComplete;
  final bool enabled;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          AppText(
              text: widget.title!,
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700),
          3.verticalSpace
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enabled,
          textCapitalization: TextCapitalization.sentences,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          maxLines: widget.maxLines ?? 1,
          cursorColor: Colors.black,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          obscureText: hidePassword && widget.isPassword,
          onChanged: widget.onChanged,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.isReadOnly,
          validator: widget.validator,
          style: GoogleFonts.itim(
              fontWeight: FontWeight.w400,
              color: widget.hintTextColor ?? Colors.white,
              fontSize: widget.hintFontSize ?? 14.sp),
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: widget.fillColor,
            filled: widget.isFilled,
            hintStyle: GoogleFonts.itim(
                fontWeight: FontWeight.w300,
                color: widget.hintTextColor ?? Colors.white,
                fontSize: widget.hintFontSize ?? 12.sp),
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            errorStyle: GoogleFonts.itim(
                fontWeight: FontWeight.w300,
                // color: widget.hintTextColor ?? Colors.white,
                fontSize: widget.hintFontSize ?? 10.sp),
            prefixIcon: widget.prefix,
            border: _border,
            enabledBorder: _border,
            focusedBorder: _focusborder,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                      log("$hidePassword");
                    },
                    child: Icon(
                        hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20.sp),
                  )
                : widget.suffix,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.withAlpha(80)),
        borderRadius: BorderRadius.circular(5.r));
  }

  OutlineInputBorder get _focusborder {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.circular(5.r));
  }
}
