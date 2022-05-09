import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/utils/utils-helpers.dart';
import 'package:waybill_sender/widgets/custom-button.dart';
import 'package:waybill_sender/widgets/custom-divider.dart';
import 'package:waybill_sender/widgets/default-app-bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waybill_sender/widgets/profile-image.dart';
class TrackingItemPage extends StatefulWidget {
  const TrackingItemPage({Key key}) : super(key: key);

  @override
  _TrackingItemPageState createState() => _TrackingItemPageState();
}

class _TrackingItemPageState extends State<TrackingItemPage> {
  GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();
  static CameraPosition initialPos = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    UtilsHelpers.setStatusBar(Colors.white);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DefaultAppBar(
            title: "Track your Package",
            backgroundColor: Colors.white,
            showNavIcon: true,
          )),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'Estimated Delivery Time:',
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
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0,
                            vertical: 20.0),
                        child: Row(
                          children: [
                            Text(
                              '45 Mins',
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
                              width: 2,
                            ),
                            Text(
                              '(20km)',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DMSans',
                                color: AppColors.greyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: CustomDivider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        Text(
                          "#603256UA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(Box of Shoes)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'DMSans',
                            color: AppColors.grey8,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(6)
                              ),
                              color: AppColors.primaryOrange.withOpacity(0.10)
                          ),
                          child: Text(
                            "In Transit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DMSans',
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: CustomDivider(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        new Image.asset(
                          'assets/images/user.png',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Alfred Olaoluwa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.6,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'DMSans',
                            color: AppColors.customDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        new Image.asset(
                          'assets/images/location.png',
                          width: 16,
                          height: 16,
                          color: AppColors.grey8,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Beside Zenith Bank, Akara Street, Imo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.6,
                            fontWeight: FontWeight.normal,
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
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ProfileImage(
                          radius: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Text(
                              'Seyitola Makinde',
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
                            padding: const EdgeInsets.symmetric(horizontal: 14.0,),
                            child: Row(
                              children: [
                                Text(
                                  'Dash Logistics',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'DMSans',
                                    color: AppColors.greyText2,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset("assets/images/verified.png",),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0,),
                            child: Text(
                              '4.5',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'DMSans',
                                color: AppColors.greyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
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
                  icon: "assets/images/call.svg",
                  onPressed: () {

                  },
                  text: 'Call Driver',
                ),
              ),
            ),
          ],
        ),
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
