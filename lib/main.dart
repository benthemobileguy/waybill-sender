import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/splash-screen.dart';
import 'package:waybill_sender/theme/app-theme.dart';
Future<void> main() async {
  // Register all the models and services before the app starts
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MainBloc>(
      create: (context) => MainBloc(),
      child: MaterialApp(
        title: 'Waybill Sender',
        debugShowCheckedModeBanner: false,
        theme: appThemeLight,
        home: SplashScreen(),
      ),
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {

    }
  }
}
