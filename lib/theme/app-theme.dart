import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static const colorShimmer = Color(0xffE6E6E6);
  static const primaryOrange = Color(0xffFAC032);
  static const circleBg = Color(0xffECEFF1);
  static const lightText = Color(0xffE0E5F2);
  static const divider = Color(0xffC4C4C4);
  static const textColor = Color(0xff010202);
  static const appBg = Color(0xffF6F7FB);
  static const greyLight = Color(0xffA3AED0);
  static const customDark = Color(0xff1B2559);
  static const placeHolder = Color(0xffF8F8F9);
  static const darkBlue = Color(0xff0040FF);
  static const buttonGrey = Color(0xffF2F2F2);
  static const dropDownCard = Color(0xffF4F7FE);
  static const grey8 = Color(0xffA3AED0);
  static const btnBg = Color(0xff010202);
  static const redBtnBg = Color(0xffD93832);
  static const borderColor = Color(0xffE9EDF7);
  static const customFabRed = Color(0xffD93832);
  final Color customRed = Color(0xffEE0000);
  static const facebookBlue = Color(0xff3A5695);
  static const greyBg = Color(0xffF8F8F9);
  static const background = Color(0xffE5E5E5);
  static const blackText = Color(0xff0F0627);
  static const textGrey = Color(0xff4A4C56);
  static const greyText2 = Color(0xff8F9BBA);
  static const customGreen = Color(0xff05CD99);
  static const googleRed = Color(0xffE05139);
  static const fontColor = Color(0xff4A4A4A);
  static const grey = Color(0xff757886);
  static const mild = Color(0xff32BBD9);
  static const grey1 = Color(0xff757886);
  static const dividerColor = Color(0xffEAEDF5);
  static const greyBgPage = Color(0xffF6F7FB);
  static const grey2 = Color(0xff303F4C);
  static const grey3 = Color(0xff4A4C56);
  static const error = Color(0xffFF5E5E);
  static const success = Color(0xff35CF4E);
}
TextStyle h1TextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  fontFamily: 'Euclid',
  color: HexColor("#010202"),
);
TextStyle h1BoldTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w600,
  fontFamily: 'Euclid',
  color: HexColor("#010202"),
);
TextStyle h4TextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w100,
  fontFamily: 'Euclid',
  color: HexColor("#757886"),
);
TextStyle h3TextStyle = TextStyle(
  fontSize: 13,
  height: 1.6,
  fontWeight: FontWeight.w100,
  fontFamily: 'Euclid',
  color: HexColor("#4A4C56"),
);
TextStyle smallTextStyle = TextStyle(
  fontSize: 12.5,
  height: 1.6,
  fontWeight: FontWeight.w100,
  fontFamily: 'Euclid',
  color: AppColors.blackText.withOpacity(0.5),
);
TextStyle h1WhiteStyle = TextStyle(
  fontSize: 24,
  height: 1.6,
  fontWeight: FontWeight.w500,
  fontFamily: 'Euclid',
  color: Colors.white,
);
TextStyle errorTextStyle = TextStyle(
  fontSize: 12,
  height: 1.6,
  fontWeight: FontWeight.w100,
  fontFamily: 'Euclid',
  color: HexColor('#EE0000'),
);
TextStyle boldh3TextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Euclid',
  color: HexColor("#010202"),
);
TextStyle boldh2TextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  fontFamily: 'Euclid',
  color: AppColors.blackText,
);
final ThemeData appThemeLight = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: const Color(0xffffffff),
  brightness: Brightness.light,
  primaryColor: AppColors.primaryOrange,
  accentColor: AppColors.primaryOrange,
  errorColor: AppColors.error,
  textTheme: GoogleFonts.latoTextTheme(),
  buttonBarTheme: const ButtonBarThemeData(alignment: MainAxisAlignment.center),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: AppColors.fontColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: AppColors.grey1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: AppColors.grey1,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: AppColors.error,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color(0x00000000),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.primaryOrange,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey2,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey1,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.grey1,
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
);
