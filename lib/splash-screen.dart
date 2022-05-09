import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/modules/auth/login_screen.dart';
import 'package:waybill_sender/modules/home/index.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/utils/pref-manager.dart';
import 'package:waybill_sender/utils/utils-helpers.dart';
import 'package:waybill_sender/widgets/base.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;
  Animation<double> _animation;
  PrefManager prefManager = PrefManager();
  MainBloc mainBloc;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    UtilsHelpers.setStatusBar(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Hero(
            tag: 'Splash Logo',
            child: new
            Image.asset('assets/images/logo.png',
                width: 260,
                height: 260, fit: BoxFit.contain),
          )),
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
    prefManager.getAuthToken().then((value){
      token = value;
      print(value);
      if(value != "auth_token" && value != null){
        Future.delayed(Duration(seconds: 5), () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder:
                (context) => Base()),
          );

        });
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder:
              (context) => LoginScreen()),
        );
      }

    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}
