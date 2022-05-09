import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
class CustomListTile extends StatelessWidget {
  final String title;
  final String image;
  final Function onPressed;
  const CustomListTile({
    Key key, this.title,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.all
            (Radius.circular(10)),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 24,
              width: 24,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.6,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSans',
                color: AppColors.greyText2,
              ),
            ),
            Spacer(),
            Image.asset(
              "assets/images/arrow_right.png",
              height: 12,
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}