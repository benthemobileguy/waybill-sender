import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ShippingCompanies extends StatelessWidget {
  const ShippingCompanies({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: SvgPicture.asset(
              "assets/images/company.svg"
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              'Dash Logistics',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'DMSans',
                color: AppColors.customDark,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Text(
              '45 Drivers Available',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.normal,
                fontFamily: 'DMSans',
                color: AppColors.greyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}