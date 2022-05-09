import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
class DefaultAppBar extends StatelessWidget {
  final String title;
  final bool showNavIcon;
  final Color backgroundColor;
  const DefaultAppBar({
    Key key,
    this.title,
    this.backgroundColor,
    this.showNavIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: new IconButton(
          icon: new Image.asset(
            'assets/images/nav.png',
            width: 24,
            height: 24,
          ),
          highlightColor: Colors.grey,
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
        actions: [
          new IconButton(
            icon: new Image.asset(
              'assets/images/notification.png',
              width: 24,
              height: 24,
            ),
            highlightColor: Colors.grey,
            onPressed: () {
            },
          ),
        ],
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w700,
            fontFamily: 'DMSans',
            color: AppColors.textColor,
          ),
        ),
        backgroundColor: backgroundColor);
  }
}