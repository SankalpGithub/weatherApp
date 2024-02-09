import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather/pages/Today.dart';
import 'package:weather/Modals/request.dart';
import 'package:weather/Modals/my_app_bar.dart';
import '../Modals/Colors.dart';
import 'package:weather/pages/History.dart';
import 'package:geolocator/geolocator.dart';


class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //TODO: VAR DECLARATION
  String lat = '0.0';
   String long = '0.0';
  final ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  bool isContent = false;
  var data = null;
  final  myPageController = PageController();
  int isTapText =  0;
  String time = "";
  String date = "";

  //TODO: METHODS

  @override
  void initState() {
    super.initState();
    //check location permission and get location info
    checkPermission();
    scrollController.addListener(() {
      setState(() {
        isScrolled = scrollController.offset > 10? true: false;
        isContent = scrollController.offset > 220? true: false;
      });
    });
  }

  List<FlSpot> spots(){
    List<FlSpot> spotList = [];
    double count = 1;
    for(int i=0; i<3; i++){
      for(int j=0; j<24; j++){
        spotList.add(FlSpot(count, data['forecast']['forecastday'][i]['hour'][j]['temp_c']));
        count++;
      }
    }
    return spotList;
  }

  List<double> checkMinMaxTemp(List<List<double>> items) {
    double min = items[0][0];
    double max = items[0][1];

    // Iterate through the remaining sub-lists
    for (List<double> range in items) {
      // Compare and update min value
      if (range[0] < min) {
        min = range[0];
      }

      // Compare and update max value
      if (range[1] > max) {
        max = range[1];
      }
    }
      return [min, max];
  }

  void checkPermission() async{
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission ask = await Geolocator.requestPermission();
      if(ask == LocationPermission.whileInUse || ask == LocationPermission.always){
        locationInfo();
      }
    }else{
      locationInfo();
    }
  }

  void locationInfo() async{
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    lat = currentPosition.latitude.toString();
    long = currentPosition.longitude.toString();
    await getData(lat:lat, long:long);
  }

  void isTap(int page){
    setState(() {
     isTapText = page;
     myPageController.animateToPage(isTapText, duration: const Duration(milliseconds: 300),curve: Curves.linear);
    });
  }

  getData({String lat = "0.0", String long = "0.0"}) async{
    Request re = Request(lat: lat, long: long);
    data = await re.fetchData();
    dateTime( await data['location']['localtime']!);
    setState(() {
    });
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

  String hour(String time){
    List<String> hours = time.split(":");
    return hours[0];
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
      body: data == null ? const Center(
        child: CircularProgressIndicator(),
      ): CustomScrollView(
        controller: scrollController,
        slivers: [

          //Main App Bar
          MyAppBar(
              address: data['location']['name'] + "," + data['location']['country'],
              tempInDegree: "${data['current']['temp_c']!.toInt().toString()}°",
              feelsLike: "feelsLike ${data['current']['feelslike_c']!.toString()}°",
              weatherDis: data['current']['condition']['text']!,
              weatherImgPath: data['current']['condition']['icon']!,
              date: date,
              time: time,
              isDay: data['current']['is_day'],
              isContent: isContent,
              isScrolled: isScrolled,
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
                  Today(

                    //windows
                    windSpeed: '${data['current']['wind_kph']!.toInt().toString()} km/h',
                    rainChance: '${data['forecast']['forecastday'][0]['day']['daily_chance_of_rain']!.toString()}%',
                    pressure: '${data['current']['pressure_in']!.toInt().toString()} hpa',
                    uvIndex: data['current']['uv']!.toInt().toString(),

                    //hourly forecast
                    hourlyForecastList: data['forecast']['forecastday'][0]['hour'],

                    //sun raise and sun set
                    sunrise: data['forecast']['forecastday'][0]['astro']['sunrise'],
                    sunset: data['forecast']['forecastday'][0]['astro']['sunset'],

                    //chance of rain
                    chanceOfRain: [
                      {"time": int.parse(hour(time)), 'percent': data['forecast']['forecastday'][0]['hour'][int.parse(hour(time))]['chance_of_rain']},
                      {"time": int.parse(hour(time))+1, 'percent': data['forecast']['forecastday'][0]['hour'][int.parse(hour(time))+1]['chance_of_rain']},
                      {"time":int.parse(hour(time))+2, 'percent': data['forecast']['forecastday'][0]['hour'][int.parse(hour(time))+2]['chance_of_rain']},
                      {"time": int.parse(hour(time))+3, 'percent': data['forecast']['forecastday'][0]['hour'][int.parse(hour(time))+3]['chance_of_rain']},
                    ],

                    //day forecast
                    min: checkMinMaxTemp([
                      [data['forecast']['forecastday'][0]['day']['mintemp_c'], data['forecast']['forecastday'][0]['day']['maxtemp_c']],
                    [data['forecast']['forecastday'][1]['day']['mintemp_c'], data['forecast']['forecastday'][1]['day']['maxtemp_c']],
                    [data['forecast']['forecastday'][2]['day']['mintemp_c'], data['forecast']['forecastday'][2]['day']['maxtemp_c']]
                    ])[0],

                    max: checkMinMaxTemp([
                      [data['forecast']['forecastday'][0]['day']['mintemp_c'], data['forecast']['forecastday'][0]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][1]['day']['mintemp_c'], data['forecast']['forecastday'][1]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][2]['day']['mintemp_c'], data['forecast']['forecastday'][2]['day']['maxtemp_c']]
                    ])[1],

                    spotList: spots(),
                    date: data['current']['last_updated'],
                    currentTime: time,

                  ),

                  Today(

                    //windows
                    windSpeed: '${data['forecast']['forecastday'][1]['hour'][0]['wind_kph']!.toInt().toString()} km/h',
                    rainChance: '${data['forecast']['forecastday'][1]['day']['daily_chance_of_rain']!.toString()}%',
                    pressure: '${data['forecast']['forecastday'][1]['hour'][0]['pressure_in']!.toInt().toString()} hpa',
                    uvIndex: data['forecast']['forecastday'][1]['hour'][0]['uv']!.toInt().toString(),

                    //hourly forecast
                    hourlyForecastList: data['forecast']['forecastday'][1]['hour'],

                    //sun raise and sun set
                    sunrise: data['forecast']['forecastday'][1]['astro']['sunrise'],
                    sunset: data['forecast']['forecastday'][1]['astro']['sunset'],

                    //chance of rain
                    chanceOfRain: [
                      {"time": int.parse(hour(time)), 'percent': data['forecast']['forecastday'][1]['hour'][int.parse(hour(time))]['chance_of_rain']},
                      {"time": int.parse(hour(time))+1, 'percent': data['forecast']['forecastday'][1]['hour'][int.parse(hour(time))+1]['chance_of_rain']},
                      {"time":int.parse(hour(time))+2, 'percent': data['forecast']['forecastday'][1]['hour'][int.parse(hour(time))+2]['chance_of_rain']},
                      {"time": int.parse(hour(time))+3, 'percent': data['forecast']['forecastday'][1]['hour'][int.parse(hour(time))+3]['chance_of_rain']},
                    ],

                    //day forecast
                    min: checkMinMaxTemp([
                      [data['forecast']['forecastday'][0]['day']['mintemp_c'], data['forecast']['forecastday'][0]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][1]['day']['mintemp_c'], data['forecast']['forecastday'][1]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][2]['day']['mintemp_c'], data['forecast']['forecastday'][2]['day']['maxtemp_c']]
                    ])[0],

                    max: checkMinMaxTemp([
                      [data['forecast']['forecastday'][0]['day']['mintemp_c'], data['forecast']['forecastday'][0]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][1]['day']['mintemp_c'], data['forecast']['forecastday'][1]['day']['maxtemp_c']],
                      [data['forecast']['forecastday'][2]['day']['mintemp_c'], data['forecast']['forecastday'][2]['day']['maxtemp_c']]
                    ])[1],

                    spotList: spots(),
                    date: data['current']['last_updated'],
                    currentTime: time,

                  ),

                  //History
                  const History()
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

        //Today option
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
                child: Text("History", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
            ))),
          ),
        ),
      ],
    );
  }
}
