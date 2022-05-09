import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/models/recent-activity.dart';
import 'package:waybill_sender/modules/packages/send-package-page.dart';
import 'package:waybill_sender/services/network-service.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/utils/string-extension.dart';
import 'package:waybill_sender/utils/utils-helpers.dart';
import 'package:waybill_sender/widgets/package-card.dart';
import 'package:waybill_sender/widgets/search-bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:waybill_sender/widgets/shimmer-list-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  TextEditingController textController = TextEditingController();
  bool upDirection = true, flag = true;
  bool isLoaded = false;

  AnimationController _animationController;
  NetworkService networkService;
  ScrollController _scrollController = ScrollController();
  MainBloc mainBloc;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _scrollController.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen: false);
    getData();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     networkService = new NetworkService(context: context);
    _setUpPositionLocator();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      value: 1.0,
      vsync: this,
    );
    _scrollController
      ..addListener(() {
        upDirection = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
        // makes sure we don't call setState too much, but only when it is needed
        if (upDirection != flag) setState(() {});
        flag = upDirection;
        flag ? _animationController.forward() : _animationController.reverse();
      });
  }
  @override
  Widget build(BuildContext context) {
    Animation<Offset> offsetAnimation = new Tween<Offset>(
      begin: Offset(0.0, -70),
      end: Offset(0.0, 0.0),
    ).animate(_animationController);
    UtilsHelpers.setStatusBar(Colors.white);
    return Scaffold(
     appBar:AppBar(
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
         title: new Image.asset('assets/images/logo.png',
             width: 121,
             height:32, fit: BoxFit.contain),
         backgroundColor: Colors.white),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Stack(
                children: [
                  Container(
                    width:double.infinity,
                    child: new Image.asset(
                        "assets/images/search_bg.png"
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          "Track your Packages",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            height: 1.6,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Enter Tracking Number/Select Package",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DMSans',
                            color: AppColors.lightText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets
                              .symmetric(horizontal: 20),
                          child: SearchBar(searchController:
                          textController,
                            icon: "assets/images/search.png",
                            borderColor: Colors.transparent,
                            hintText: "e.g #603256UA",
                            fillColor: AppColors.dividerColor,
                            showIcon:true,),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "Recent Activity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'DMSans',
                        color: AppColors.customDark,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "See All",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'DMSans',
                        color:AppColors.greyText2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              !isLoaded?ShimmerListView():ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: mainBloc.recentActivity.length,
                itemBuilder: (BuildContext context, int index) {

                  return PackageCard(
                  senderName: mainBloc.recentActivity[index].sender,
                  receiverName: mainBloc.recentActivity[index].recieverName,
                  trackingNo: mainBloc.recentActivity[index].trackingNo,
                  from: mainBloc.recentActivity[index].from,
                  status: mainBloc.recentActivity[index].status.capitalize(),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: 20.0,
            child: AnimatedContainer(
              width: flag ? 170 : 56,
              height: 56,
              duration: Duration(milliseconds: 300),
              child: FloatingActionButton.extended(
                backgroundColor: AppColors.darkBlue,
                heroTag: 'Send Package',
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:
                        (context) => SendPackagePage()),
                  );
                },
                label: AnimatedSwitcher(
                  duration: Duration(seconds: 0),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                      FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          child: child,
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                        ),
                      ), child: !flag
                    ? Image.asset(
                  "assets/images/package.png",
                  width: 24,
                  height: 24,
                ) : Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Image.asset(
                        "assets/images/package.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      'Send Package',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSans',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
  _setUpPositionLocator() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    print(currentPosition);
  }

  void getData() {
    networkService.getActivity().then((value){
     setState(() {
       isLoaded = true;
       mainBloc.recentActivity = RecentActivity.fromJsonList(value["data"]);
     });
    });
  }
}

