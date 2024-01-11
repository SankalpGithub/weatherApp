import 'package:flutter/material.dart';
import 'Colors.dart';

class MyAppBar extends StatefulWidget{
  final String address;
  final String tempInDegree;
  final String feelsLike;
  final String weatherDis;
  final String weatherImgPath;
  final String date;
  final String time;
  final String dayDegree;
  final String nightDegree;


  const MyAppBar(
      {
        super.key,
    required this.address,
    required this.tempInDegree,
    required this.feelsLike,
    required this.weatherDis,
    required this.weatherImgPath,
    required this.date,
    required this.time,
    required this.dayDegree,
    required this.nightDegree
  });

  @override
  State<MyAppBar> createState() => MyAppBarState();
}

class MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return buildStack(context);
  }

  Stack buildStack(BuildContext context) {
    return Stack(
    children: [

      //Appbar bg image
     Container(
        width: MediaQuery.of(context).size.width,
        height: 412,
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/main_bg.png"),
                fit:  BoxFit.fill
            ),
            color: Colors.grey,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(33), bottomRight: Radius.circular(33))
        ),
      ),

      //information
      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20, top: 50),
        child: Column(
          children: [

            //row for address and search
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //address
                Text(widget.address, style: const TextStyle(color: my_white, fontSize: 22),),

                //search
                const Icon(Icons.search, color: my_white,)
              ],
            ),

            //row for tempDegree and weatherStatus
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //stack of tempDegree and feelsLike
                  Container(
                      margin: const EdgeInsets.only(top: 85),
                      child:
                      Stack(
                          children: [

                            //tempDegree
                            Text(
                              widget.tempInDegree, style: const TextStyle(
                              fontSize: 112,
                              fontWeight: FontWeight.w400,
                              color: my_white,
                            ),
                            ),

                            //feelsLike
                            Container(
                                margin: const EdgeInsets.only(top: 85, left: 75),
                                child: Text(widget.feelsLike, style: const TextStyle(fontSize: 18, color: my_white),
                                )
                            )
                          ]
                      )
                  ),

                  // column for weatherImgPath and weatherDescription
                  Container(
                      margin: const EdgeInsets.only(bottom: 50,),
                      child: Column(
                        children: [

                          //weather Image
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Image.asset(widget.weatherImgPath, scale: 1.5,),
                          ),

                          //weather description
                          Text(widget.weatherDis, style:const TextStyle(fontSize: 22, color: my_white),)
                        ],
                      )
                  )
                ]
            ),

            //row for date/time and degree of day and night
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //date and time
                  Text("${widget.date}, ${widget.time}",
                    style: const TextStyle(
                      color: my_white, fontSize: 18
                  ),
                  ),

                  //column for dayDegree and nightDegree
                  Column(
                    children: [

                      //dayDegree
                      Text(widget.dayDegree,
                        style: const TextStyle(
                          color: my_white, fontSize: 18
                      ),
                      ),

                      //nightDegree
                      Text(widget.nightDegree,
                        style: const TextStyle(
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