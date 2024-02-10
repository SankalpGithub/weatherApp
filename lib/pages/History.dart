import 'package:flutter/material.dart';
import 'package:weather/Modals/Colors.dart';

class History extends StatefulWidget {
   const History({super.key});

  @override
  State<History> createState() => HistoryState();
}

class HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                return
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                      height: 86,
                      width: 200,
                      decoration: BoxDecoration(
                        color: windows.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Saturday, Feb 10', style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Couldy', style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300
                                ),)
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 150,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: Column(
                                      children: [
                                        Text('30°', style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        ),),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('29°', style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        ),)
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: 2,
                                    height: 50,
                                    color: my_black.withOpacity(0.5),
                                  ),

                                  Image.asset("assets/images/Group1.png")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
          });
  }
}
