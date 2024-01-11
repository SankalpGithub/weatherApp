import 'package:flutter/material.dart';
import 'Colors.dart';


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
              istap("10 days");
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