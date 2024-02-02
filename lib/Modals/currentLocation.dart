// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../screens/Home.dart';
//
//
//
// class GetCurrentLocation extends StatefulWidget {
//   const GetCurrentLocation({super.key});
//
//   @override
//   State<GetCurrentLocation> createState() => _GetCurrentLocationState();
// }
//
// class _GetCurrentLocationState extends State<GetCurrentLocation> {
//
//   dynamic currentLocation ;
//   getCurrentLocation() async{
//     dynamic lat;
//     dynamic long;
//     Map<String, dynamic> resp = {
//       'lat': lat,
//       'long': long
//     };
//     LocationPermission permission = await Geolocator.checkPermission();
//       if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//         LocationPermission ask = await Geolocator.requestPermission();
//
//         return resp;
//       }else{
//         Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//         lat = currentPosition.latitude.toString();
//         long = currentPosition.longitude.toString();
//         return resp;
//       }
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:  Text('${currentLocation['lat']}'),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     currentLocation = getCurrentLocation();
//     if (currentLocation['lat']== null || currentLocation['long'] == null){
//
//     }
//     else{
//       Navigator.push(context, MaterialPageRoute(
//           builder: (context) => Home(lat: currentLocation['lat'], long: currentLocation['long'])
//       )
//       );
//     }
//     setState(() {
//     });
//   }
// }
