import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color color, disabledColor, borderColor;

  MainButton({
    this.onPressed,
    this.child,
    this.borderColor,
    this.color,
    this.disabledColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement custom properties
    return Container(
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: color != null ? color : Theme.of(context).primaryColor,
        textColor: HexColor("#110027"),
        elevation: 4.0,
        disabledColor: disabledColor != null
            ? disabledColor
            : Theme.of(context).accentColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
            side: BorderSide(color: borderColor)),
      ),
    );
  }
}
