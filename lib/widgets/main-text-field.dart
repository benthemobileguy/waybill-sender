import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';

class MainTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String Function(String) validator;
  final String Function(String) onChanged;
  final bool enabled;
  final Color enabledBorderColor;
  final TextInputType textInputType;
  final Widget icon;
  final TextEditingController textEditingController;
  MainTextField({ this.label,
    this.hint,
    this.onChanged,
    this.enabled,
    this.icon,
    this.textEditingController,
    this.textInputType,
    this.validator,
    this.enabledBorderColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: new EdgeInsets.all(0.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: enabledBorderColor,

                )
            ),
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: TextFormField(
              onChanged: onChanged,
              controller: textEditingController,
              keyboardType: textInputType,
              validator: validator,
              cursorColor: AppColors.greyText2,
              textAlign: TextAlign.start,
              enabled: enabled,
              decoration: InputDecoration(
                labelText: hint,
                labelStyle: TextStyle(
                    color: AppColors.greyText2,
                    fontFamily: "DMSans",
                    fontSize: 14
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder:InputBorder.none,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            top: 10.0,
            child: icon,
          ),
        ],
      ),
    );
  }
}
