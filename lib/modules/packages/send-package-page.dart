import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waybill_sender/modules/tracking/tracking-item-page.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/widgets/base.dart';
import 'package:waybill_sender/widgets/card-arrow.dart';
import 'package:waybill_sender/widgets/custom-button.dart';
import 'package:waybill_sender/widgets/custom-divider.dart';
import 'package:waybill_sender/widgets/default-app-bar.dart';
import 'package:waybill_sender/widgets/familiar-face.dart';
import 'package:waybill_sender/widgets/main-text-field.dart';
import 'package:waybill_sender/widgets/material-details.dart';
import 'package:waybill_sender/widgets/search-bar.dart';
import 'package:lottie/lottie.dart';
import 'package:waybill_sender/widgets/shipping-companies.dart';
import 'package:waybill_sender/widgets/top-suggestions.dart';

class SendPackagePage extends StatefulWidget {
  const SendPackagePage({Key key}) : super(key: key);

  @override
  _SendPackagePageState createState() => _SendPackagePageState();
}

class _SendPackagePageState extends State<SendPackagePage> {
  TextEditingController receiverNameController = new TextEditingController();
  TextEditingController _pickupController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _sendingController = TextEditingController();
  TextEditingController _otherDetailsController = TextEditingController();
  final maxLines = 5;
  String title = "Basic Details";

  final PageController _pageController = PageController(initialPage: 0);
  int currentPageValue = 0;
  String deliveryType = "Select delivery type";
  String packageWeight = "Select estimated package weight";
  String transportType = "Select transport type";
  Completer<GoogleMapController> _controller = Completer();
  static CameraPosition initialPos = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14.4746);
  TextEditingController textEditingController = new TextEditingController();

  GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DefaultAppBar(
            title: currentPageValue!=5?
            "$title (${currentPageValue + 1}/5)":
            title,
            backgroundColor: Colors.white,
            showNavIcon: true,
          )),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPageValue = page;
            switch (page){
              case 0:
                title = "Basic Details";
                break;
              case 1:
                title = "Package Details";
                break;
              case 2:
                title = "Select Dispatcher";
                break;
              case 3:
                title = "Shipment Summary";
                break;
              case 4:
                title = "Payment Method";
                break;
              case 5:
                title = "Request Successful";
                break;
            }
          });
        },
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 240,
                  child: GoogleMap(
                    initialCameraPosition: initialPos,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                        () => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      _controller.complete(controller);

                      _setUpPositionLocator();
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Pickup Location',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBar(
                      searchController: _pickupController,
                      icon: "assets/images/current.png",
                      borderColor: AppColors.customDark,
                      hintText: "User Current Location",
                      fillColor: Colors.white,
                      showIcon: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Destination',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBar(
                      searchController: _destinationController,
                      icon: "assets/images/destination.png",
                      borderColor: AppColors.customDark,
                      hintText: "Destination Location",
                      fillColor: Colors.white,
                      showIcon: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Delivery Type',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CardArrow(
                          title: deliveryType,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.customDark,
                        ),
                        DropdownButtonHideUnderline(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: AppColors.lightText,
                            ),
                            child: DropdownButton<String>(
                                icon: Container(),
                                items: <String>[
                                  'All Packages',
                                  'New Packages',
                                ].map((String value) {
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
                                          style: TextStyle(
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
                                onChanged: (val) {
                                  setState(() {
                                    deliveryType = val;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Select Mode of Transport',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CardArrow(
                          title: transportType,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.customDark,
                        ),
                        DropdownButtonHideUnderline(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: AppColors.lightText,
                            ),
                            child: DropdownButton<String>(
                                icon: Container(),
                                items: <String>[
                                  'God is good',
                                  'Dispatch Rider',
                                ].map((String value) {
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
                                          style: TextStyle(
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
                                onChanged: (val) {
                                  setState(() {
                                    transportType = val;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 55,
                  width: double.infinity,
                  child: CustomButton(
                    borderColor: AppColors.darkBlue,
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    text: 'Continue to Package Details',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'What are you sending?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: MainTextField(
                    enabledBorderColor: AppColors.greyText2,
                    label: 'e.g "Box of shoes"',
                    hint: 'e.g "Box of shoes"',
                    enabled: true,
                    textEditingController: _sendingController,
                    icon: Container(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Name of Receiver',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: MainTextField(
                    enabledBorderColor: AppColors.greyText2,
                    label: 'Enter Receiver Name',
                    hint: 'Enter Receiver Name',
                    enabled: true,
                    textEditingController: receiverNameController,
                    icon: Container(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Receiver's Phone Number",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: MainTextField(
                    enabledBorderColor: AppColors.greyText2,
                    label: 'e.g 08100599608',
                    hint: 'e.g 08100599608',
                    enabled: true,
                    textInputType: TextInputType.number,
                    textEditingController: receiverNameController,
                    icon: Container(),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Package Weight",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DMSans',
                      color: AppColors.customDark,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        CardArrow(
                          title: packageWeight,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.greyText2,
                        ),
                        DropdownButtonHideUnderline(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: AppColors.lightText,
                            ),
                            child: DropdownButton<String>(
                                icon: Container(),
                                items: <String>[
                                  'All Packages',
                                  'New Packages',
                                ].map((String value) {
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
                                          style: TextStyle(
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
                                onChanged: (val) {
                                  setState(() {
                                    packageWeight = val;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Text(
                        "Additional Details",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DMSans',
                          color: AppColors.customDark,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(Optional)",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                          color: AppColors.greyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: TextField(
                    controller: _otherDetailsController,
                    maxLines: maxLines,
                    cursorColor: Colors.black26,
                    decoration: InputDecoration(
                        filled: true,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DMSans',
                          color: AppColors.grey1,
                        ),
                        hintText:
                            "Include any other information/instructions about your package",
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColors.greyText2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColors.greyText2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColors.greyText2),
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 55,
                  width: double.infinity,
                  child: CustomButton(
                    borderColor: AppColors.darkBlue,
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    text: 'Continue to Select Dispatcher',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Stack(
            children: [
              SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SearchBar(
                        searchController: _pickupController,
                        icon: "assets/images/search.png",
                        borderColor: AppColors.customDark,
                        hintText: "Search for Driver/Company",
                        fillColor: Colors.white,
                        showIcon: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: CustomDivider(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Familiar Faces',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'See All',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FamiliarFace(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: CustomDivider(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Top Suggestions',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'See All',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TopSuggestions(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: CustomDivider(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Shipping Companies',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'See All',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DMSans',
                            color: AppColors.greyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShippingCompanies(),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
              Positioned(
                bottom: 20.0,
                right: 0.0,
                left: 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 55,
                  width: double.infinity,
                  child: CustomButton(
                    borderColor: AppColors.darkBlue,
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    text: 'Continue to Shipment Summary',
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 240,
                      child: GoogleMap(
                        initialCameraPosition: initialPos,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                                () => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                          _controller.complete(controller);

                          _setUpPositionLocator();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Selected Dispatcher',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                          color: AppColors.greyText2,
                        ),
                      ),
                    ),
                    TopSuggestions(

                    ),
                    MaterialDetails(
                      title: 'Package Name',
                      subtitle: 'Box of Shoes and Perfume',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialDetails(
                      title: 'Pickup Location',
                      subtitle: '64, Omagbemi Estate, Lagos State',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "Estimated Shipping Fees",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DMSans',
                              color: AppColors.greyText2,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "1500",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DMSans',
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: CustomDivider(),
                    ),
                    MaterialDetails(
                      title: 'Delivery Type',
                      subtitle: 'Instant (Same Day Delivery)',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialDetails(
                      title: 'Mode of Transport',
                      subtitle: 'Motorcycle',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialDetails(
                      title: 'Name of Receiver',
                      subtitle: 'Alred Osasu',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialDetails(
                      title: "Receiver's Phone Number",
                      subtitle: 'Motorcycle',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        MaterialDetails(
                          title: "Quantity",
                          subtitle: '2',
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        MaterialDetails(
                          title: "Package Weight",
                          subtitle: '2 Pounds',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialDetails(
                      title: 'Additional Details',
                      subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor integer eget cursus scelerisque ut a tortor tortor. Feugiat auctor pellentesque massa ultrices lorem ac.',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
                      child: Text(
                        "Photos of the Package",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DMSans',
                          color: AppColors.greyText2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 20.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 55,
                  width: double.infinity,
                  child: CustomButton(
                    borderColor: AppColors.darkBlue,
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    text: 'Continue to Payment',
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        'Pay with Card',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DMSans',
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                   Container(
                     margin: EdgeInsets.all(14),
                     padding: EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(
                         Radius.circular(10),
                       ),
                       border: Border.all(
                         color: AppColors.grey8,
                       )
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         new Image.asset(
                           "assets/images/plus.png",
                           height: 16, width: 16,),
                         SizedBox(
                           width: 6,
                         ),
                         Text(
                           'Add New Card',
                           textAlign: TextAlign.start,
                           style: TextStyle(
                             fontSize: 14,
                             height: 1.5,
                             fontWeight: FontWeight.w700,
                             fontFamily: 'DMSans',
                             color: AppColors.grey8,
                           ),
                         ),
                       ],
                     ),
                   ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        'Pay with Wallet',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DMSans',
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(14),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: AppColors.grey8,
                          )
                      ),
                      child: Row(
                        children: [
                          new Image.asset(
                            "assets/images/wallet.png",
                            height: 26, width: 26,),
                          SizedBox(
                            width: 14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add New Card',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DMSans',
                                  color: AppColors.grey8,
                                ),
                              ),
                              Text(
                                '15,000',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'DMSans',
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          new Image.asset(
                            "assets/images/check.png",
                            height: 18, width: 18,),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        'Pay on Pickup',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DMSans',
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(14),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: AppColors.grey8,
                          )
                      ),
                      child: Row(
                        children: [
                          new Image.asset(
                            "assets/images/chart.png",
                            height: 26, width: 26,),
                          SizedBox(
                            width: 14,
                          ),
                          Text(
                            'Choose to pay in dispatcher in cash',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DMSans',
                              color: AppColors.grey8,
                            ),
                          ),
                          Spacer(),
                          new Image.asset(
                            "assets/images/check.png",
                            height: 18, width: 18,),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: CustomDivider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          Text(
                            'Estimated Shipping Fees:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'DMSans',
                              color: AppColors.greyText2,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '1500',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DMSans',
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: CustomDivider(),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 20.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 55,
                  width: double.infinity,
                  child: CustomButton(
                    borderColor: AppColors.darkBlue,
                    color: AppColors.darkBlue,
                    textColor: Colors.white,
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    text: 'Confirm Payment',
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Lottie.asset(
                'assets/lottie/done.json',
                width: 112,
                height: 112,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Text(
                  'Your request has been sent and your dispatcher will contact you soon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DMSans',
                    color: AppColors.greyText2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Tracking ID is',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'DMSans',
                        color: AppColors.greyText2,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '#603256UA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 2.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: 'DMSans',
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: CustomDivider(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 55,
                width: double.infinity,
                child: CustomButton(
                  borderColor: AppColors.darkBlue,
                  color: AppColors.darkBlue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder:
                          (context) => Base()),
                    );
                  },
                  text: 'Back to Home',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 55,
                width: double.infinity,
                child: CustomButton(
                  borderColor: AppColors.greyText2,
                  color: Colors.white,
                  textColor: AppColors.greyText2,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder:
                          (context) => TrackingItemPage())
                    );
                  },
                  text: 'Go to Tracking',
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _setUpPositionLocator() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    _mapController = await _controller.future;
    LatLng pos = LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: pos, zoom: 14);
    await _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}


