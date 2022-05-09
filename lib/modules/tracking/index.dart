import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waybill_sender/theme/app-theme.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/widgets/default-app-bar.dart';
import 'package:waybill_sender/widgets/search-bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TrackingPage extends StatefulWidget {
  const TrackingPage({Key key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  Completer<GoogleMapController> _controller = Completer();
  static CameraPosition initialPos= CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude), zoom: 14.4746);
  TextEditingController textEditingController = new TextEditingController();

  GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dividerColor,
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: DefaultAppBar(
            title: 'Track your Package',
            backgroundColor: Colors.white,
            showNavIcon: true,
          )),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialPos,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(()
              => new EagerGestureRecognizer(),),
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
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets
                    .symmetric(horizontal: 20),
                child: SearchBar(searchController:
                textEditingController,
                  icon: "assets/images/search.png",
                  borderColor: Color(0xffA3AED0),
                  hintText: "Enter Tracking Number/Select Package",
                  fillColor: Colors.white,
                  showIcon:true,),
              ),
            ),
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
   // setUpMap();
  }
}
