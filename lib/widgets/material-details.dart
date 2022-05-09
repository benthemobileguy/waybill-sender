import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
class MaterialDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  const MaterialDetails({
    Key key, this.title, this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'DMSans',
              color: AppColors.greyText2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
          child: Text(
            subtitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: 'DMSans',
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}