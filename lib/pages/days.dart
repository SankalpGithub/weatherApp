import 'package:flutter/material.dart';
import 'package:weather/Modals/sticky_appbar.dart';
import '../Modals/Colors.dart';

class days extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: sticknav,
              expandedHeight: 130,
              floating: false,
              pinned: true,
              snap: false,
              toolbarHeight: 130,
              collapsedHeight: 130,
              automaticallyImplyLeading: false,
              title: sticky_appbar(),
          ),
      SliverAppBar(
        toolbarHeight: 30,
        snap: false,
        backgroundColor:sticknav,
        pinned: true,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: option(),
          collapseMode: CollapseMode.parallax,
        ),
      ),
      ]
      ),
    );
  }

}