
import 'package:earthexpapp/screens/webview.dart';
import 'package:flutter/material.dart';
// import 'dart:html';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
      title: const Text('About', style: TextStyle(color: Colors.green),),
      // elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.green,)
          ),
      ),

      body: Center(
        child: Column(
          children: [
            Image.asset(
              "images/logo.png",
              width: 200,
              height: 200,

              ),
              Container(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: const Text(
                  "EarthExp describes three roles of technology in driving sustainable behaviour; amplifying the potential for users to achieve goals through the users experiencing their annual emissions in virtual reality, a determinant where behaviour is shaped and activated on the basis of affordances, constraints, and cues provided by the technological environment through the simulation, and as a promoter influencing behavioural choices by enhancing problem awareness using the feeds, trends, and articles.",
                  style: TextStyle(fontSize: 14, ),
                   textAlign: TextAlign.justify,
                  ),
              ),
              const SizedBox(height: 30,),


              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 204, 203, 203))
                ),

                child: ListTile(
                  leading: const Icon(Icons.lock, color: Colors.green,),
                  title: const Text('Privacy policy'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Webview("https://www.termsfeed.com/live/99425d93-ba31-4825-a218-777ce0e2bb61")));
                  },
                )
              )



          ],
        )
        
        ),


    );
  }
}