import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../pages/Home.dart';



class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {

  var currentLocation ;
  getCurrentLocation() async{
    LocationPermission permission = await Geolocator.checkPermission();
    while(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      LocationPermission ask = await Geolocator.requestPermission();
      String resp = "You need to give your location permission";
      return resp;
    }
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      String lat = currentPosition.latitude.toString();
      String long = currentPosition.longitude.toString();
      await Navigator.push(context, MaterialPageRoute(builder: (context) => Home(lat: lat, long: long)
      )
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Text('${currentLocation}'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentLocation = getCurrentLocation();
    setState(() {
    });
  }
}
