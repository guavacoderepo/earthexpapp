import 'package:earthexpapp/screens/about.dart';
import 'package:earthexpapp/screens/game.dart';
import 'package:earthexpapp/screens/profile.dart';
import 'package:flutter/material.dart';
import '../models/shareddata.dart';
import '../realtime/object detection.dart';
import 'article.dart';
import 'carbonfoot print.dart';
import 'feeds.dart';
import 'login.dart';
import 'trends.dart';


class utils{
  
var shared  = SharedData();

  AppBar appBar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "EarthExp", 
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold
          ),
        ),
      centerTitle: true,

      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.more_vert,color: Colors.black,),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ],
    );
  }

  Drawer drawer(BuildContext context, String value){
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  value.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.green,),
                title: const Text('Profile'),
                onTap: (){
                  
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const profile()));
                },
              ),

              ListTile(
                leading: const Icon(Icons.calculate, color: Colors.green,),
                title: const Text('Carborn footprint'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const FootPrint()));
                },
              ),

              ListTile(
                leading: const Icon(Icons.question_answer_sharp,color: Colors.green,),
                title: const Text('About'),
                onTap: (){
                  
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const About()));
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.green,),
                title: const Text('Logout'),
                onTap: (){
                  shared.removeValues();
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const Login()));
                },
              ),

            ],
          ),
    );
  } 
}



class bottomnav extends StatefulWidget {
  int select;
  
  bottomnav(this.select, { Key? key }) : super(key: key);

  @override
  State<bottomnav> createState() => bottomnavState(select);
}

class bottomnavState extends State<bottomnav> {

  int select;
  bottomnavState(this.select);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: select,
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 70, 68, 68).withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // elevation: 0,
        onTap: (int index){
          setState(() {
            if(index==0){
              select = 0;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const ObjectDetection()));
            }else if(index==1){
              select = 1;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const trends()));
            }else if(index==2){
              select = 2;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const feeds()));
            }else if(index==3){
              select = 3;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const article()));
            }
            else if(index==4){
              select = 4;
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const game()));
            }
            else {
              
            }
          });
        },
        
        items: const [
          BottomNavigationBarItem(label: "AI/AR/VR", icon: Icon(Icons.workspaces_outlined)),
          BottomNavigationBarItem(label: "Trend", icon: Icon(Icons.trending_down),),
          BottomNavigationBarItem(label: "Feed", icon: Icon(Icons.feed_outlined),),
          BottomNavigationBarItem(label: "Article", icon: Icon(Icons.format_indent_decrease_rounded),),
          BottomNavigationBarItem(label: "Game", icon: Icon(Icons.videogame_asset_rounded),)
        ]
    );
  }
}