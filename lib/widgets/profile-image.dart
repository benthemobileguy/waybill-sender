import 'package:flutter/material.dart';
class ProfileImage extends StatelessWidget {
  final double radius;
  const ProfileImage({
    this.radius,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset("assets/images/default_avatar.png",
          height: radius,
          width: radius,));
    // return CircularProfileAvatar(
    //   Constants().profileURL,
    //   //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
    //   radius: radius,
    //   // sets radius, default 50.0
    //   backgroundColor: Colors.transparent,
    //   // sets background color, default Colors.white
    //   borderWidth: 0.5,
    //   borderColor: HexColor("#D5DDE0"),
    //   elevation: 0.0,
    //   //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
    //   cacheImage: true,
    //   // allow widget to cache image against provided url
    //   onTap: () {},
    //   // sets on tap
    //   showInitialTextAbovePicture:
    //   true, // setting it true will show initials text above profile picture, default false
    // );
  }
}