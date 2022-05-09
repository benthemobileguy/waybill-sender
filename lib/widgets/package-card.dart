import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/widgets/custom-divider.dart';
import 'package:waybill_sender/widgets/profile-image.dart';

class PackageCard extends StatelessWidget {
  final String senderName;
  final String receiverName;
  final String trackingNo;
  final String status;
  final String from;
  const PackageCard({
    Key key,
    this.senderName,
    this.receiverName,
    this.trackingNo,
    this.from,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all
            (Radius.circular(10)),
          border: Border.all(
              color: AppColors.dividerColor,
              width: 1
          )
      ),
      child:  Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                Text(
                  "#$trackingNo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DMSans',
                    color: AppColors.customDark,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "(Box of Shoes)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.6,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DMSans',
                    color: AppColors.grey8,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(6)
                      ),
                      color: status=="Failed"?
                      Colors.red.withOpacity(0.10):
                      status=="Received"?
                      Colors.orange.withOpacity(0.10):
                      Color(0xff05CD99).withOpacity(0.10)
                  ),
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                      color: status=="Failed"?
                      Colors.red:
                      status=="Received"?
                      Colors.orange:
                      Color(0xff05CD99),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                new Image.asset(
                  'assets/images/user.png',
                  width: 16,
                  height: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  receiverName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'DMSans',
                    color: AppColors.customDark,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                new Image.asset(
                  'assets/images/location.png',
                  width: 16,
                  height: 16,
                  color: AppColors.grey8,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  from,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DMSans',
                    color: AppColors.grey8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: ProfileImage(
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  senderName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DMSans',
                    color: AppColors.customDark,
                  ),
                ),
                Spacer(),
                Text(
                  "Fri, Aug 13",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DMSans',
                    color: AppColors.grey8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}