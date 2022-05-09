import 'package:flutter/material.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/utils/string-extension.dart';
import 'package:waybill_sender/widgets/card-arrow.dart';
import 'package:waybill_sender/widgets/default-app-bar.dart';
import 'package:waybill_sender/widgets/package-card.dart';
import 'package:provider/provider.dart';
class PackagesPage extends StatefulWidget {
  const PackagesPage({Key key}) : super(key: key);

  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  String showSelected = "All Packages";
  String newestSelected = "Newest";
  MainBloc mainBloc;
   @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mainBloc = Provider.of<MainBloc>(context, listen: false);
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DefaultAppBar(
            title: 'My Packages',
            backgroundColor: Colors.white,
            showNavIcon: true,
          )),
      body:  Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric
                  (horizontal: 14),
                child: Row(
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          CardArrow(
                            title: "Show: $showSelected",
                            backgroundColor: AppColors.dropDownCard,
                            borderColor: AppColors.dropDownCard,
                          ),
                          DropdownButtonHideUnderline(
                            child:Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: AppColors.lightText,
                              ),
                              child: DropdownButton<String>(
                                  icon: Container(),
                                  items: <String>['All Packages',
                                    'New Packages',].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Text(
                                            value,
                                            textAlign: TextAlign.center,
                                            style:TextStyle(
                                              fontSize: 12.5,
                                              height: 1.6,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DMSans',
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val){
                                    setState(() {
                                      showSelected = val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          CardArrow(
                            title: "Sort by: $newestSelected",
                            backgroundColor: AppColors.dropDownCard,
                            borderColor: AppColors.dropDownCard,
                          ),
                          DropdownButtonHideUnderline(
                            child:Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: AppColors.lightText,
                              ),
                              child: DropdownButton<String>(
                                  icon: Container(),
                                  items: <String>['Newest Findings',
                                    'Previous Findings',].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Text(
                                            value,
                                            textAlign: TextAlign.center,
                                            style:TextStyle(
                                              fontSize: 12.5,
                                              height: 1.6,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DMSans',
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val){
                                    setState(() {
                                      newestSelected = val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
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
            bottom: 30.0,
            right: 0.0,
            child: Container(
              margin: EdgeInsets.all(16),
              width: 55,
              height: 55,
              child: FloatingActionButton(
                backgroundColor: AppColors.darkBlue,
                tooltip: 'Search',
                onPressed: () {

                },
                child:  Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset("assets/images/search.png",
                      height: 20,
                      width: 20,
                      color:Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getData() {

  }
}
