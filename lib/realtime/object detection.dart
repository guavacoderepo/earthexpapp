import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:store_redirect/store_redirect.dart'; 
import '../screens/feeds.dart';
import '../screens/utils.dart';
import '../models/shareddata.dart';
import '../screens/webview.dart';
import 'live_camera.dart';
// import 'dart:html';

List<CameraDescription> cameras = [];


class ObjectDetection extends StatefulWidget {
  const ObjectDetection({ Key? key }) : super(key: key);

  @override
  State<ObjectDetection> createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {

  var util = utils();
  int select = 0;
  String value  =  "";
  var shared = SharedData();
  void cameraDetection() async{

    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LiveFeed(cameras),
      ),
    );    
  }

  
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

      body: Center(
        child: Column(
          children: [
            Center(
              child: Image.network(
                // "images/carbon.png",
                "https://www.schroders.com/en/sysglobalassets/staticfiles/campaigns/singapore/climate-change-investing/img/infographic2-m-1.gif",
                )
            ),
            const SizedBox(height: 50,),
            // const CircularProgressIndicator(color: Colors.green),
            const SizedBox(height: 30,),
            
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: (){cameraDetection();}, 
                    child: const Text("AI carbon emitters detector", style: TextStyle(fontSize: 15),),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
                      shadowColor: const Color.fromARGB(255, 78, 73, 72),
                      // onPrimary: Color.fromARGB(222, 253, 253, 253),
                      primary: const Color.fromARGB(222, 47, 117, 23),
                    ),
                  ),

                  const SizedBox(height: 40,),


                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Webview("https://www.instagram.com/ar/544828013649231")));
                    }, 
                    child: const Text("AR social filter", style: TextStyle(fontSize: 15),),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
                      shadowColor: const Color.fromARGB(255, 78, 73, 72),
                      // onPrimary: Color.fromARGB(222, 253, 253, 253),
                      primary: const Color.fromARGB(222, 47, 117, 23),
                    ),
                  ),
                  
                  const SizedBox(height: 30,),

                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Webview("https://ecoelixirs.itch.io/earthexperience")));
                    }, 
                    child: const Text("VR EarthExperience app", style: TextStyle(fontSize: 15),),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
                      shadowColor: const Color.fromARGB(255, 78, 73, 72),
                      // onPrimary: Color.fromARGB(222, 253, 253, 253),
                      primary: const Color.fromARGB(222, 47, 117, 23),
                    ),
                  ),
                  const SizedBox(height: 10,),

                  const Text("Click to download EarthExperience app from the above link", style: TextStyle(color: Color.fromARGB(255, 131, 141, 132)),),

                
                  const SizedBox(height: 10,),
                  const Text("Step 1 : Download the cardboard app"),
                  const SizedBox(height: 10,),
                  const Text("Step 2 : Run the EarthExperience on the Cardboard app"),
                  const SizedBox(height: 10,),
                  const Text("Step 3 : Experience it in Virtual Reality."),
                ],
              ),
            )


          ],
        ),
      )
    ),
  );
}