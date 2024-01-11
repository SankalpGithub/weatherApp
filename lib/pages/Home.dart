import 'package:flutter/material.dart';
import 'package:weather/Modals/main_content/today.dart';
import 'package:weather/Modals/request.dart';
import 'package:weather/Modals/my_app_bar.dart';
import '../Modals/Colors.dart';
import '../Modals/option.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  bool isContent = false;
  late Future<void> data;
  final PageController myPageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Request re = Request();
    data = re.fetchData();
    scrollController.addListener(() {
      setState(() {
        isScrolled = scrollController.offset > 10? true: false;
        isContent = scrollController.offset > 220? true: false;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: my_bg,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [

            //Main App Bar
            MyAppBar(
                address: "Kharkiv , Ukrain",
                tempInDegree: "3°",
                feelsLike: "feelsLike -2°",
                weatherDis: "cloudy",
                weatherImgPath: "assets/images/cloud and sun 1.png",
                date: "January 18",
                time: "16:14",
                dayDegree: "Day 3°",
                nightDegree: "Night -1°",
                isContent: isContent,
                isScrolled: isScrolled
            ),

            //options
            SliverAppBar(
              toolbarHeight: 30,
              snap: false,
              backgroundColor: isContent?sticknav: my_bg,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: option(),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverToBoxAdapter(
              child: PageView(
                controller: myPageController,
                children: [
                  today(),
                ],
              ),
            )
          ],
        )
      );
  }
}
