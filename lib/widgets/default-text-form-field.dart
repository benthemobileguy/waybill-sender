import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:waybill_sender/theme/app-theme.dart';

class DefaultTextFormField extends StatelessWidget {
  final Function onChanged;
  final Widget prefixIcon;
  final String hintText;
  final int maxLength;
  final Color underlineColor;
  final Color borderColor;
  final  List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final FocusNode focus, nextFocus;
  final TextInputAction textInputAction;
  final Widget suffixIcon;
  final Color textColor;
  final TextCapitalization textCapitalization;
  final bool enableInteractiveSession;
  final bool obscureText, disabled;
  final String initialValue;
  final String fillColorCode;
  final Function(String) validator;
  final TextEditingController controller;
  final VoidCallback onTap;

  DefaultTextFormField({
    this.onChanged,
    this.textColor,
    this.textCapitalization,
    this.enableInteractiveSession,
    this.underlineColor,
    this.maxLength,
    this.prefixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.focus,
    this.nextFocus,
    this.disabled = false,
    this.textInputAction,
    this.validator,
    this.fillColorCode = '#FFFFFF',
    this.onTap,
    this.suffixIcon,
    this.initialValue,
    this.obscureText = false,
    this.controller,
    @required this.hintText,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0,
          right: 0),
      height: 50,
      child: TextFormField(
        enableInteractiveSelection: enableInteractiveSession
            !=null?enableInteractiveSession:true,
        cursorColor: AppColors.customDark,
        controller: controller,
        onChanged: this.onChanged,
        inputFormatters: inputFormatters,
        onTap: onTap,
        textCapitalization: textCapitalization!=null?
        textCapitalization:TextCapitalization.none,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.bottom,
        enabled: !disabled,
        validator: validator,
        style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'DMSans',
            fontWeight: FontWeight.w400,
            color: textColor!=null?
            textColor:
            Colors.black
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: HexColor(fillColorCode),
          contentPadding: EdgeInsets.all(18.0),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(12.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(12.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(12.0),
            ),
          ),
          hintText: this.hintText,
          prefixIcon: this.prefixIcon,
          //prefixStyle: subheadingTextStyle,
          hintStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontFamily: "DMSans",
            color: HexColor("#6B6A6A"),
          ),
        ),
        focusNode: this.focus,
        obscureText: obscureText,
        textInputAction: this.textInputAction != null
            ? this.textInputAction
            : TextInputAction.done,
        onFieldSubmitted: (v) {
          if (this.nextFocus != null) {
            FocusScope.of(context).requestFocus(this.nextFocus);
          }
        },
        keyboardType:
        this.keyboardType != null ?
        this.keyboardType
            : TextInputType.text,
      ),
    );
  }
}
