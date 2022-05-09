import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/modules/account/index.dart';
import 'package:waybill_sender/modules/home/index.dart';
import 'package:waybill_sender/modules/packages/index.dart';
import 'package:waybill_sender/modules/tracking/index.dart';
import 'package:waybill_sender/theme/app-theme.dart';

class Base extends StatefulWidget {
  static String routeName = '/base';
  final int currentIndex;
  Base({Key key, this.currentIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BaseState();
  }
}

class _BaseState extends State<Base> {
  MainBloc mainBloc;
  int _currentIndex = 0;

  final scaffoldKeyBase = new GlobalKey<ScaffoldState>();
  ifNotNull() {
    if (widget.currentIndex != null) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }

  @override
  void initState() {
    ifNotNull();

    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context);
  }
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext ctx) {
    List<Widget> _children = [
      new HomePage(),
      new PackagesPage(),
      new TrackingPage(),
      new AccountPage()
    ];
    return new Scaffold(
      key: scaffoldKeyBase,
      bottomNavigationBar: new BottomNavigationBar(
        elevation: 3,
        currentIndex: _currentIndex,
        selectedFontSize: 14.0,
        fixedColor: AppColors.darkBlue,
        unselectedItemColor: AppColors.greyLight,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child:ImageIcon(
                  AssetImage(
                    "assets/images/home.png",
                  ),
                  size: 25,
                )
            ),
            label: "Home",
          ),
          new BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child:ImageIcon(
                  AssetImage(
                    "assets/images/packages.png",
                  ),
                  size: 25,
                )
            ),
            label: "My Packages",
          ),
          new BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child:ImageIcon(
                  AssetImage(
                    "assets/images/tracking.png",
                  ),
                  size: 25,
                )
            ),
            label: "Tracking",
          ),
          new BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child:ImageIcon(
                  AssetImage(
                    "assets/images/account.png",
                  ),
                  size: 25,
                )
            ),
            label: "Account",
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
