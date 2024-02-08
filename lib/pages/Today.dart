import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Modals/Colors.dart';

class Today extends StatefulWidget {
  //var for window
  final String windSpeed;
  final String rainChance;
  final String pressure;
  final String uvIndex;

  //var for hourly forecast
  final List hourlyForecastList;

  //sunrise and sunset
  final String sunrise;
  final String sunset;

  //rain chance
  final List chanceOfRain;

  //day forecast
  final double min;
  final double max;

  const Today(
      {super.key,
      required this.windSpeed,
      required this.rainChance,
      required this.pressure,
      required this.uvIndex,

      //for hourly forecast
      required this.hourlyForecastList,

      //sunrise and sunset
      required this.sunrise,
      required this.sunset,

      //chance of rain
      required this.chanceOfRain,

      //day forecast
      required this.min,
      required this.max});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<Color> gradientColors = [
    const Color(0xFF2B00A5).withOpacity(0.5),
    windows,
    my_white
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
      case 24:
        text = const Text('Tue', style: style);
        break;
      case 48:
        text = const Text('Wed', style: style);
        break;
      // case 4:
      //   text = const Text('Thu', style: style);
      //   break;
      // case 5:
      //   text = const Text('Fri', style: style);
      //   break;
      // case 6:
      //   text = const Text('Sat', style: style);
      //   break;
      // case 7:
      //   text = const Text('Sun', style: style);
      //   break;
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
      fontSize: 15,
    );
    String text = '';
    // switch (value.toInt()) {
    //   case 10:
    //     text = ' 10° ';
    //     break;
    //   case 0:
    //     text = ' 0° ';
    //     break;
    //   case -10:
    //     text = '-10° ';
    //     break;
    //   default:
    //     return Container();
    // }

    // if(value == widget.min){
    //   text == '${widget.min}°';
    // }
    // if(value == widget.max){
    //   text = "${widget.max}°";
    // }
    double avg = (widget.max + 3 + widget.min)/2;
    Map<dynamic, dynamic> actions = {
      widget.max.toInt() + 4: ' ${widget.max.toInt() + 4}° ',
      avg.toInt(): ' ${avg.toInt()}° ',
      widget.min.toInt() -2: ' ${widget.min.toInt() - 2}° ',
      // Add more cases as needed
    };

    if (actions.containsKey(value.toInt())) {
      text = actions[value.toInt()]; // Execute the function associated with the action
    } else {
      text = '';
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  String dayStatus(int time) {
    String status = "";
    time < 12 && time == 24 ? status = "AM" : status = "PM";
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        window(),

        hourly_forecast(),

        day_forecast(),

        chanceOfRain(),

        sunriseAndSet(),
      ],
    );
  }

  Container sunriseAndSet() {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 10),

      //row for sunrise and sunset
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //sunrise
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 65,
            width: 182,
            decoration: BoxDecoration(
                color: windows.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //image
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: my_white, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    "assets/images/nights_stay.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sunrise",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    Text(widget.sunrise,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: const Text("4h ago",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500)))
              ],
            ),
          ),

          //sunset
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 65,
            width: 182,
            decoration: BoxDecoration(
                color: windows.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //image
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: my_white, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    "assets/images/routine.png",
                    height: 16,
                    width: 16,
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sunset",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    Text(widget.sunset,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),

                Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: const Text("in 9h",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container chanceOfRain() {
    return Container(
        margin: const EdgeInsets.only(
          top: 16,
        ),
        width: 380,
        height: 213,
        decoration: BoxDecoration(
            color: windows.withOpacity(0.3),
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                // image
                Container(
                  margin: const EdgeInsets.all(11),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: my_white, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset("assets/images/rainy.png"),
                ),

                const Text("Chance of rain",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              ],
            ),

            //progress bars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${widget.chanceOfRain[0]['time'].toString()} ${dayStatus(widget.chanceOfRain[0]['time'])}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                Container(
                  height: 24,
                  width: 229,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    backgroundColor: my_white,
                    valueColor: const AlwaysStoppedAnimation<Color>(lines),
                    value: widget.chanceOfRain[0]['percent'] / 100,
                  ),
                ),
                Text(
                  '${widget.chanceOfRain[0]['percent'].toString()}%',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${widget.chanceOfRain[1]['time'].toString()} ${dayStatus(widget.chanceOfRain[1]['time'])}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                Container(
                  height: 24,
                  width: 229,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    backgroundColor: my_white,
                    valueColor: const AlwaysStoppedAnimation<Color>(lines),
                    value: widget.chanceOfRain[1]['percent'] / 100,
                  ),
                ),
                Text('${widget.chanceOfRain[1]['percent'].toString()}%',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${widget.chanceOfRain[2]['time'].toString()} ${dayStatus(widget.chanceOfRain[2]['time'])}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                Container(
                  height: 24,
                  width: 229,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    backgroundColor: my_white,
                    valueColor: const AlwaysStoppedAnimation<Color>(lines),
                    value: widget.chanceOfRain[2]['percent'] / 100,
                  ),
                ),
                Text('${widget.chanceOfRain[2]['percent'].toString()}%',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    '${widget.chanceOfRain[3]['time'].toString()} ${dayStatus(widget.chanceOfRain[3]['time'])}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                Container(
                  height: 24,
                  width: 229,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    backgroundColor: my_white,
                    valueColor: const AlwaysStoppedAnimation<Color>(lines),
                    value: widget.chanceOfRain[3]['percent'] / 100,
                  ),
                ),
                Text('${widget.chanceOfRain[3]['percent'].toString()}%',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500))
              ],
            ),
          ],
        ));
  }

  Container day_forecast() {
    return  Container(
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
                        maxX: 48,
                        minY: widget.min.toInt() -2,
                        maxY: widget.max.toInt() + 4,
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
                              reservedSize: 48,
                              getTitlesWidget: leftTitleWidgets,
                              interval:1
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
                              // //day 1
                              //  FlSpot(1, 0),
                              //  FlSpot(2, 12),
                              //  FlSpot(3, 15),
                              //  FlSpot(4, 36),
                              //  FlSpot(5, 36),
                              //  FlSpot(6, 36),
                              //  FlSpot(7, 36),
                              //  FlSpot(8, 36),
                              //  FlSpot(9, 36),
                              //  FlSpot(10, 36),
                              //  FlSpot(11, 36),
                              //  FlSpot(12, 36),
                              //  FlSpot(13, 36),
                              //  FlSpot(14, 36),
                              //  FlSpot(15, 36),
                              //  FlSpot(16, 36),
                              //  FlSpot(17, 36),
                              //  FlSpot(18, 36),
                              //  FlSpot(19, 36),
                              //  FlSpot(20, 36),
                              //  FlSpot(21, 36),
                              //  FlSpot(22, 36),
                              //  FlSpot(23, 36),
                              //  FlSpot(24, 36),
                              //
                              // //day 2
                              // FlSpot(1, 35),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              //
                              // //day 3
                              // FlSpot(1, 35),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),
                              // FlSpot(1.1, 36),

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
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(11),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: my_white, borderRadius: BorderRadius.circular(20)),
                  child: Image.asset("assets/images/history_toggle_off.png"),
                ),
                Text("Hourly forecast",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              ],
            ),
            Container(
              width: 350,
              height: 100,
              child: ListView.builder(
                  itemCount: widget.hourlyForecastList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              index < 12
                                  ? "${index + 1} AM"
                                  : "${index + 1} PM",
                              style: TextStyle(
                                  fontSize: 13.16,
                                  fontWeight: FontWeight.w500)),
                          Image.network(
                            'https:${widget.hourlyForecastList[index]["condition"]['icon']}',
                            height: 55,
                            width: 55,
                          ),
                          Text(
                              '${widget.hourlyForecastList[index]["temp_c"].toString()}°',
                              style: TextStyle(
                                  fontSize: 18.18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ));
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
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "assets/images/air.png",
                          height: 16,
                          width: 16,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Wind speed",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(widget.windSpeed,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  height: 65,
                  width: 182,
                  decoration: BoxDecoration(
                      color: windows.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "assets/images/rainy.png",
                          height: 16,
                          width: 16,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rain chance",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(widget.rainChance,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500))
                        ],
                      ),
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
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "assets/images/waves.png",
                          height: 16,
                          width: 16,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pressure",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(widget.pressure,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  height: 65,
                  width: 182,
                  decoration: BoxDecoration(
                      color: windows.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: my_white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "assets/images/light_mode.png",
                          height: 16,
                          width: 16,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("UV Index",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(widget.uvIndex,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
