import 'package:flutter/material.dart';
import 'package:weather/Modals/Colors.dart';
import 'package:weather/pages/Home.dart';
import 'package:flutter/services.dart';

import 'Modals/currentLocation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
       systemNavigationBarColor: my_bg
    ));
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: GetCurrentLocation(),
    );
  }
}

