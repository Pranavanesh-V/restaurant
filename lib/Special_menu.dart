import 'package:flutter/material.dart';

class SpecialMenu extends StatelessWidget {

  List<List<String>>? d;

  SpecialMenu(List<List<String>> d)
  {
    this.d=d;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: d!.length,
      itemBuilder: (BuildContext context,int index){
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/mixed grill.png",width: 80,height: 80,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d![index][0],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text(d![index][1]),
                      SizedBox(width: 200,
                          child: Text(d![index][2],maxLines: 2,overflow: TextOverflow.ellipsis,)
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
