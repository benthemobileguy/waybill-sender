import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/widgets/profile-image.dart';
import 'package:flutter_svg/flutter_svg.dart';
class TopSuggestions extends StatelessWidget {
  const TopSuggestions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: ProfileImage(
              radius: 50,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'Seyitola Makinde',
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
                padding: const EdgeInsets.symmetric(horizontal: 14.0,),
                child: Row(
                  children: [
                    Text(
                      'Dash Logistics',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'DMSans',
                        color: AppColors.greyText2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset("assets/images/verified.png",),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0,),
                child: Text(
                  '4.5',
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
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Available',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'DMSans',
                  color: AppColors.customGreen,
                ),
              ),
              SizedBox(
                height:16,
              ),
              Text(
                '12-15 Mins Away',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'DMSans',
                  color: AppColors.greyText2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}