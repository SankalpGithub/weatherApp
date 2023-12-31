import 'package:flutter/material.dart';
import 'package:weather/Modals/request.dart';
import 'package:weather/Modals/sticky_appbar.dart';
import '../Modals/Colors.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatefulWidget{

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
bool isScrolled = false;
bool isContent = false;
String istaptext = "today";

  @override
  void initState() {
    Request re = new Request();
    re.fetchData();
    _scrollController.addListener(() {
      setState(() {
        isScrolled = _scrollController.offset > 10? true: false;
        isContent = _scrollController.offset > 220? true: false;
      });
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Color> gradientColors = [
  Color(0xFF2B00A5).withOpacity(0.5),
    windows,
    my_white
  ];

  List hourly_forecast_list = [
    {"time": "Now", "image": "assets/images/Group1.png", "degree": "10°"},
    {"time": "10AM", "image": "assets/images/Group2.png", "degree": "8°"},
    {"time": "11AM", "image": "assets/images/Group2.png", "degree": "5°"},
    {"time": "12PM", "image": "assets/images/Group1.png", "degree": "12°"},
    {"time": "1PM", "image": "assets/images/Group1.png", "degree": "9°"},
    {"time": "2PM", "image": "assets/images/Group2.png", "degree": "12°"},
  ];



  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Mon', style: style);
        break;
      case 2:
        text = const Text('Tue', style: style);
        break;
      case 3:
        text = const Text('Wed', style: style);
        break;
      case 4:
        text = const Text('Thu', style: style);
        break;
      case 5:
        text = const Text('Fri', style: style);
        break;
      case 6:
        text = const Text('Sat', style: style);
        break;
      case 7:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = ' 10° ';
        break;
      case 0:
        text = ' 0° ';
        break;
      case -10:
        text = '-10° ';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: my_bg,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
          SliverAppBar(
            backgroundColor: isContent?sticknav: my_bg,
          expandedHeight: 365.0,
          floating: false,
          pinned: true,
          snap: false,
          toolbarHeight: isScrolled?130:365,
          collapsedHeight: isScrolled?130:365,
          title: isContent?sticky_appbar():Container(),
          flexibleSpace: FlexibleSpaceBar(
            background: buildStack(context),
            collapseMode: CollapseMode.parallax,
          )
        ),
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
              child: window(),
            ),
            SliverToBoxAdapter(
              child: hourly_forecast(),
            ),

            SliverToBoxAdapter(
              child: day_forecast(),
            ),
            SliverToBoxAdapter(
              child: chance_of_rain(),
            ),
            SliverToBoxAdapter(
              child: sunriseAndSet(),
            )
          ],
        )
      );

  }


  Container sunriseAndSet() {
    return Container(
            margin: const EdgeInsets.only(top: 24, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 65,
                  width: 182,
                  decoration: BoxDecoration(
                      color: windows.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)
                        ),child: Image.asset("assets/images/nights_stay.png" ,height: 16, width: 16,),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sunrise", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          )),

                          Text("4:20 AM", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ))
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: const Text("4h ago", style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                          )
                          )
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  height: 65,
                  width: 182,
                  decoration: BoxDecoration(
                      color: windows.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)
                        ),child: Image.asset("assets/images/routine.png" ,height: 16, width: 16,),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sunset", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          )),

                          Text("4:50 PM", style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Text("in 9h", style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500
                          )
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Container chance_of_rain() {
    return Container(
            margin: EdgeInsets.only(top: 16, left: 10, right: 10),
            width: 380,
            height: 213,
            decoration: BoxDecoration(
                color: windows.withOpacity(0.3),
                borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(11),
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                          color: my_white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image.asset("assets/images/rainy.png"),
                    ),
                    Text("Chance of rain", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("7 PM", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),

                  Container(
                    height: 24,
                    width: 229,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: my_white,
                      valueColor: new AlwaysStoppedAnimation<Color>(lines),
                      value: 0.27,
                    ),
                  ),
                      Text("27%", style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      )
                        ,)
              ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("8 PM", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),

                      Container(
                        height: 24,
                        width: 229,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(100),
                          backgroundColor: my_white,
                          valueColor: new AlwaysStoppedAnimation<Color>(lines),
                          value: 0.44,
                        ),
                      ),
                      Text("44%", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ))
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("9 PM", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),

                      Container(
                        height: 24,
                        width: 229,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(100),
                          backgroundColor: my_white,
                          valueColor: new AlwaysStoppedAnimation<Color>(lines),
                          value: 0.56,
                        ),
                      ),
                      Text("56%", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ))
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("10 PM", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),

                      Container(
                        height: 24,
                        width: 229,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(100),
                          backgroundColor: my_white,
                          valueColor: new AlwaysStoppedAnimation<Color>(lines),
                          value: 0.88,
                        ),
                      ),
                      Text("88%", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ))
                    ],
                  ),
                ),
              ],
            )
          );
  }

  Container day_forecast() {
    return Container(
            margin: EdgeInsets.only(top: 16, left: 10, right: 10),
            width: 380,
            height: 219,
            decoration: BoxDecoration(
                color: windows.withOpacity(0.3),
                borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(11),
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                          color: my_white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image.asset("assets/images/calendar_month.png"),
                    ),
                    Text("Day forecast", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  height: 120,
                  width: 370,
                  color: Colors.transparent,
                  child: LineChart(
                    LineChartData(
                     minX: 1,
                      maxX: 7,
                      minY: -10,
                      maxY: 10,
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                        show: true,
                          horizontalInterval: 9.9,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: my_black.withOpacity(0.13),
                          );
                        },
                        drawVerticalLine: false
                      ),

                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                              reservedSize: 45,
                              getTitlesWidget: leftTitleWidgets,
                              interval: 1,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: bottomTitleWidgets,
                              interval: 1,
                            ),
                          ),
                        ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(1, -5),
                            FlSpot(1.5, -1),
                            FlSpot(2, -3),
                            FlSpot(2.4, -1),
                            FlSpot(3, -3),
                            FlSpot(3.6, -1),
                            FlSpot(4.4, 3),
                            FlSpot(5.4, -1),
                            FlSpot(6, -2),
                            FlSpot(6.5, -5),
                            FlSpot(7, 0),
                          ],
                          isCurved: true,
                          dotData: FlDotData(show: false),
                          color: my_black,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                            ),
                          ),
                        )
                      ],
                      showingTooltipIndicators: [
                        ShowingTooltipIndicators([

                        ]),
                      ]
                    )
                  )
                ),
              ],
            )
          );
  }

  Container hourly_forecast() {
    return Container(
            margin: EdgeInsets.only(top: 16, left: 10, right: 10),
            width: 380,
            height: 150,
            decoration: BoxDecoration(
              color: windows.withOpacity(0.3),
              borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(11),
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: my_white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image.asset("assets/images/history_toggle_off.png"),
                    ),
                    Text("Hourly forecast", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ))
                  ],
                ),
                Container(
                  width: 350,
                  height: 90,
                  child: ListView.builder(
                      itemCount: hourly_forecast_list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(hourly_forecast_list[index]["time"],
                              style: TextStyle(
                                  fontSize: 13.16,
                                  fontWeight: FontWeight.w500
                          )),
                          Image.asset(hourly_forecast_list[index]["image"], height: 32, width: 24,),
                          Text(hourly_forecast_list[index]["degree"], style: TextStyle(
                              fontSize: 18.18,
                              fontWeight: FontWeight.w500

                          ))
                        ],
                      ),
                    );
                  }),
                ),
              ],
            )
          );
  }

  Container window() {
    return Container(
            margin: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 65,
                      width: 182,
                      decoration: BoxDecoration(
                          color: windows.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              color: my_white,
                              borderRadius: BorderRadius.circular(20)
                            ),child: Image.asset("assets/images/air.png" ,height: 16, width: 16,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Wind speed", style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )),

                              Text("12km/h", style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text("2 km/h", style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500
                              )
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      height: 65,
                      width: 182,
                      decoration: BoxDecoration(
                          color: windows.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                color: my_white,
                                borderRadius: BorderRadius.circular(20)
                            ),child: Image.asset("assets/images/rainy.png" ,height: 16, width: 16,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rain chance", style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )),

                              Text("24%", style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text("10%", style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500
                              )))
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      height: 65,
                      width: 182,
                      decoration: BoxDecoration(
                          color: windows.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                color: my_white,
                                borderRadius: BorderRadius.circular(20)
                            ),child: Image.asset("assets/images/waves.png" ,height: 16, width: 16,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pressure", style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )),

                              Text("720 hpa", style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text("32 hpa", style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500
                              )
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      height: 65,
                      width: 182,
                      decoration: BoxDecoration(
                          color: windows.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                color: my_white,
                                borderRadius: BorderRadius.circular(20)
                            ),child: Image.asset("assets/images/light_mode.png" ,height: 16, width: 16,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("UV Index", style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )),

                              Text("2,3", style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ))
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text("0.3h", style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500
                              )))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 412,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/main_bg.png"),
                        fit:  BoxFit.fill),
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(33), bottomRight: Radius.circular(33))
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20, top: 50),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Kharkiv, Ukraine", style: TextStyle(color: my_white, fontSize: 22),),
                          Icon(Icons.search, color: my_white,)
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              Container(
                                margin: EdgeInsets.only(top: 85),
                                    child:
                                    Stack(
                                    children: [
                                    Text("3°", style: TextStyle(
                                      fontSize: 112,
                                      fontWeight: FontWeight.w400,
                                      color: my_white,
                                    ),
                                    ),
                              Container(
                                margin: EdgeInsets.only(top: 85, left: 75),
                                  child: Text("Feels like -2°", style: TextStyle(fontSize: 18, color: my_white),))
                                    ]
                          )
                              ),
                          Container(
                            margin: EdgeInsets.only(bottom: 50,),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Image.asset("assets/images/cloud and sun 1.png", scale: 1.5,),
                                ),
                                Text("Cloudy", style: TextStyle(fontSize: 22, color: my_white),)
                              ],
                            )
                          )
                        ]
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("January 18, 16:14", style: TextStyle(
                              color: my_white, fontSize: 18
                            ),),
                            Column(
                              children: [
                                Text("Day 3°" ,style: TextStyle(
                                color: my_white, fontSize: 18
                            ),),
                                Text("Night -1°", style: TextStyle(
                                    color: my_white, fontSize: 18
                                ),)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              ),
            ],
          );
  }
}

// class _10_days extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
//
// }
