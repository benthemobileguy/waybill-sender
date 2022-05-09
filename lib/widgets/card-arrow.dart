import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
class CardArrow extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  const CardArrow({
    Key key,
    this.title,
    this.backgroundColor,
    this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color:
          borderColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )
      ),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
              color: AppColors.textColor,
            ),
          ),
          Spacer(),
          new Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.grey8,
          )
        ],
      ),
    );
  }
}