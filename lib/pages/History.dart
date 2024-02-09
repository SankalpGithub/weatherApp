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
                      height: 84,
                      width: 200,
                      decoration: BoxDecoration(
                        color: windows.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('date'),
                              Text('condition')
                            ],
                          ),
                          Column(
                            children: [
                              Text('temp_c'),
                              Text('feelsLike')
                            ],
                          ),
                          
                          Image.asset("assets/images/Group1.png")
                        ],
                      ),
                    );
          });
  }
}
