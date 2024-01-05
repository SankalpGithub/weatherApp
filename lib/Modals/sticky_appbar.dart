import 'package:flutter/material.dart';

import '../pages/days.dart';
import 'Colors.dart';

class sticky_appbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Kharkiv, Ukraine", style: TextStyle(color: my_black, fontSize: 22),),
            Icon(Icons.search, color: my_black,)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child:
                    Stack(
                        children: [
                          Text("3°", style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w400,
                            color: my_black,
                          ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 35, left: 40),
                              child: Text("Feels like -2°", style: TextStyle(fontSize: 16, color: my_black),))
                        ]
                    )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Image.asset("assets/images/cloud and sun 1.png", width: 59,height: 59,),
                ),
              ]
          ),
        ),

      ],
    );
  }
}

class option extends StatefulWidget{

  @override
  State<option> createState() => _optionState();
}

class _optionState extends State<option> {

  String istaptext = "today";

  void istap(String text){
    setState(() {
      istaptext = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              istap("today");
            },
            child: Container(
              height: 42,
              width: 116,
              decoration: BoxDecoration(
                  color: istaptext=="today"?options: my_white,
                  borderRadius: BorderRadius.circular(14)
              ),
              child: Center(child: Text("Today", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ))),
            ),
          ),

          GestureDetector(
            onTap: (){
              istap("tomorrow");
            },
            child: Container(
              height: 42,
              width: 116,
              decoration: BoxDecoration(
                  color: istaptext=="tomorrow"?options: my_white,
                  borderRadius: BorderRadius.circular(14)
              ),
              child: Center(child: Text("Tomorrow",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              )
              )
              ),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => days()
              )
              );
            },
            child: Container(
              height: 42,
              width: 116,
              decoration: BoxDecoration(
                  color: istaptext == "10 days"?options: my_white,
                  borderRadius: BorderRadius.circular(14)
              ),
              child: Center(child: Text("10 days", style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ))),
            ),
          ),
        ],
      ),
    );
  }
}