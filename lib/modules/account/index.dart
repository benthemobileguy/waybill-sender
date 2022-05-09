import 'package:flutter/material.dart';
import 'package:waybill_sender/modules/auth/login_screen.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/widgets/base.dart';
import 'package:waybill_sender/widgets/custom-divider.dart';
import 'package:waybill_sender/widgets/custom-list-tile.dart';
import 'package:waybill_sender/widgets/default-app-bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DefaultAppBar(
            title: 'Waybill Account',
            backgroundColor: Colors.white,
            showNavIcon: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: SvgPicture.asset("assets/images/company.svg",),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Track your Packages",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.5,
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DMSans',
                          color: AppColors.customDark,
                        ),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text(
                        "64, Omagbemi Estate, Lagos State",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.6,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'DMSans',
                          color: AppColors.greyText2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Packages\nSent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "206",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                      ],
                    ),
                  Spacer(),
                    Column(
                      children: [
                        Text(
                          "198",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Successfully\nDelivered",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "14",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Companies\nFollowed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomListTile(
                image: "assets/images/user2.png",
                title: "Edit Account Details",
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                image: "assets/images/payment.png",
                title: "Payment Method",
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                image: "assets/images/user2.png",
                title: "Followed Companies",
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                image: "assets/images/reviews.png",
                title: "Reviews",
              ),
              SizedBox(
                height: 30,
              ),
              CustomDivider(
              ),
              SizedBox(
                height: 30,
              ),

              CustomListTile(
                image: "assets/images/help.png",
                title: "Help & Support",
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)
                      => LoginScreen()));
                },
                image: "assets/images/log_out.png",
                title: "Log Out",
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


