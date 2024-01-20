import 'package:flutter/material.dart';
import 'package:weather/Modals/main_content/today.dart';
import 'package:weather/Modals/request.dart';
import 'package:weather/Modals/my_app_bar.dart';
import '../Modals/Colors.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //TODO: VAR DECLARATION
  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  bool isContent = false;
  Map<String, dynamic> data = {};
  final  myPageController = PageController();
  int isTapText =  0;
  String time = "";
  String date = "";

  //TODO: METHODS
  void isTap(int page){
    setState(() {
     isTapText = page;
     myPageController.animateToPage(isTapText, duration: Duration(milliseconds: 300),curve: Curves.linear);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      setState(() {
        isScrolled = scrollController.offset > 10? true: false;
        isContent = scrollController.offset > 220? true: false;
      });
    });
  }

  void getData() async{
    Request re = Request();
    data = await re.fetchData();
    dateTime(data['location']['localtime']!);
  }
  
  void dateTime(String dateTime){
    List<String> dateTimeList = dateTime.split(" ");
    List<String> dateList = dateTimeList[0].split("-");
    time = dateTimeList[1];
    String month = "";
    switch(dateList[1]){
      case '01': month="January";break;
      case '02': month="February";break;
      case '03': month="March";break;
      case '04': month="April";break;
      case '05': month="May";break;
      case '06': month="June";break;
      case '07': month="July";break;
      case '08': month="August";break;
      case '09': month="September";break;
      case '10': month="October";break;
      case '11': month="November";break;
      case '12': month="December";break;
    }
     date = '$month ${dateList[2]}';
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

//TODO: BUILD METHOD
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: my_bg,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [

            //Main App Bar
            MyAppBar(
                address: data['location']['name']! + "," + data['location']['country']!,
                tempInDegree: "${data['current']['temp_c']!.toInt().toString()}°",
                feelsLike: "feelsLike ${data['current']['feelslike_c']!.toString()}°",
                weatherDis: data['current']['condition']['text']!,
                weatherImgPath: data['current']['condition']['icon']!,
                date: date,
                time: time,
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
            
            //BODY
            SliverToBoxAdapter(
              child: SizedBox(
                height: 893,
                child: PageView(
                  onPageChanged: (int index){
                    isTap(index);
                  },
                  controller: myPageController,
                  children: [
                    today(
                      windSpeed: data['current']['wind_kph']!,
                      rainChance: data['forecast']['forecastday']['0']['day']['daily_chance_of_rain']!,
                      pressure: data['current']['pressure_in']!,
                      uvIndex: data['current']['uv']!,
                    ),
                    today(
                      windSpeed: data['current']['wind_kph']!,
                      rainChance: data['forecast']['forecastday']['0']['day']['daily_chance_of_rain']!,
                      pressure: data['current']['pressure_in']!,
                      uvIndex: data['current']['uv']!,
                    ),
                    today(
                      windSpeed: data['current']['wind_kph']!,
                      rainChance: data['forecast']['forecastday']['0']['day']['daily_chance_of_rain']!,
                      pressure: data['current']['pressure_in']!,
                      uvIndex: data['current']['uv']!,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      );
  }

  //TODO: MY WIDGETS
  Row option() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        //today option
        GestureDetector(
          onTap: (){
            isTap(0);
          },
          child: Container(
            height: 42,
            width: 116,
            decoration: BoxDecoration(
                color: isTapText==0?options: my_white,
                borderRadius: BorderRadius.circular(14)
            ),
            child: const Center(
                child:Text("Today", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ))),
          ),
        ),

        //tomorrow option
        GestureDetector(
          onTap: (){
            isTap(1);
          },
          child: Container(
            height: 42,
            width: 116,
            decoration: BoxDecoration(
                color: isTapText==1?options: my_white,
                borderRadius: BorderRadius.circular(14)
            ),
            child: const Center(
                child: Text("Tomorrow",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            )
            )
            ),
          ),
        ),

        //10 days option
        GestureDetector(
          onTap: (){
            isTap(2);
          },
          child: Container(
            height: 42,
            width: 116,
            decoration: BoxDecoration(
                color: isTapText == 2?options: my_white,
                borderRadius: BorderRadius.circular(14)
            ),
            child: const Center(
                child: Text("10 days", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ))),
          ),
        ),
      ],
    );
  }
}
