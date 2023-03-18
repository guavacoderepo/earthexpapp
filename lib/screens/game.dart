import 'package:flutter/material.dart';
import '../screens/feeds.dart';
import '../screens/utils.dart';
import '../models/shareddata.dart';
import '../screens/webview.dart';


class game extends StatefulWidget {
  const game({ Key? key }) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {

  var util = utils();
  int select = 4;
  String value  =  "";
  var shared = SharedData();

  
  _onWillPop(){
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => const feeds()));
  }


  @override
  void initState() {
    super.initState();
    shared.loadperfString().then((String name) {
      setState(() {
        this.value  = name;
      });
    });
    
  }



  @override
 Widget build(BuildContext context)  => WillPopScope(
    
    onWillPop: () async{
      // print("back pressed");
      return _onWillPop();
    }, 
  
  
    child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: util.appBar(),
      bottomNavigationBar: bottomnav(select),
      endDrawer: util.drawer(context, value),

      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            
            imgAdds("https://img.itch.zone/aW1hZ2UvMTUwMzI5OS84NzYzNDgwLnBuZw==/original/7wNMzA.png"),
            imgAdds("https://img.itch.zone/aW1hZ2UvMTUwMzI5OS84NzYzNTA1LnBuZw==/original/iDn21M.png"),
            

            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Webview("https://ecoelixirs.itch.io/thexp")));
              }, 
              child: const Text("Click to download TheXp app"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
                shadowColor: const Color.fromARGB(255, 78, 73, 72),
                // onPrimary: Color.fromARGB(222, 253, 253, 253),
                primary: const Color.fromARGB(222, 47, 117, 23),
              ),
            ),
            const SizedBox(height: 30,),

            
           
          ],
        ),
      )
    ),
  );
}



Image imgAdds(String url){
  return Image.network(
    url,
    fit: BoxFit.fitWidth,
    width: double.maxFinite,
    height: 220,
    loadingBuilder: (BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return SizedBox(
        height: 220,
        child: Center(
          child: CircularProgressIndicator(
          color: const Color.fromARGB(255, 215, 216, 218),
          value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
            ),
          ),
        );
    },
  );
}