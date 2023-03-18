// ignore_for_file: deprecated_member_use, camel_case_types
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../models/shareddata.dart';
import 'utils.dart';
import 'webview.dart';
// import 'dart:html';

class feeds extends StatefulWidget {
  const feeds({ Key? key }) : super(key: key);

  @override
  State<feeds> createState() => _feedsState();
}

class _feedsState extends State<feeds> {


  String curDay = DateFormat("EEE").format(DateTime.now());
  String d1 = DateFormat("EEE").format(DateTime.now().add(const Duration(days: 1)));
  String d2 = DateFormat("EEE").format(DateTime.now().add(const Duration(days: 2)));
  String d3 = DateFormat("EEE").format(DateTime.now().add(const Duration(days: 3)));
  String d4 = DateFormat("EEE").format(DateTime.now().add(const Duration(days: 4)));

  // add(new Duration(days: 1)
  
  String curDate = DateFormat("d").format(DateTime.now());

  String end = "";
  var util = utils();
  var shared = SharedData();

  bool isLoading = true;
  String value  =  "";

  String read = " ";
  int select = 2;

  Future<bool> _onWillPop() async {
  return (
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit the App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                shared.savevarpef(end);
                Navigator.of(context).pop(true);
                exit(0);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
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

      endDrawer: util.drawer(context, value.toUpperCase()),


     body: Container(
        child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              Container(
                
                margin: const EdgeInsets.only(top: 5, left: 30, right: 30,bottom: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(96, 107, 105, 105)),
                  color: const Color.fromARGB(255, 240, 239, 239),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText("Today", 15, FontWeight.w200),
                        const SizedBox(width: 40,),
                        appText("$curDay,", 15, FontWeight.w200),
                        const SizedBox(width: 10,),
                        appText(curDate, 15, FontWeight.w200),
                        const SizedBox(width: 10,),
                        const Icon(Icons.wb_cloudy_outlined),
                        const SizedBox(width: 10,),
                        appText("Sunny", 15, FontWeight.w200),

                        // const Icon(Icons.wb_cloudy_outlined),
                      ],
                    ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          appText("Weather", 18, FontWeight.w200),
                          appText(d1, 10, FontWeight.w200),
                          appText(d2, 10, FontWeight.w200),
                          appText(d3, 10, FontWeight.w200),
                          appText(d4, 10, FontWeight.w200),
                        ],
                      ),
                      SizedBox(height: 4,),

                      Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          appText("Forcast", 18, FontWeight.w200),
                          const Icon(Icons.wb_cloudy_outlined),
                          const Icon(Icons.cloud),
                          const Icon(Icons.cloudy_snowing),
                          const Icon(Icons.wb_cloudy)
                        ],
                      )

                  ],
                ),
              ), 
     
     
     
     
     Container(
      height: (MediaQuery. of(context). size. height)-263,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [

            imgAdds("https://thumbs.gfycat.com/AgonizingAncientIndianhare-size_restricted.gif"), 
            const SizedBox(height: 15,),
            img(context, "Osinbajo gets update on next UN meeting on Climate Change", "https://i0.wp.com/businessday.ng/wp-content/uploads/2021/10/Yemi-Osinbajo.png?resize=702%2C400&ssl=1", "https://businessday.ng/news/article/osinbajo-gets-update-on-next-un-meeting-on-climate-change/"),
            const SizedBox(height: 30,),
            img(context, "Greta Thunberg speaks for Africa when it comes to climate. Where are Africa's voices?", "https://www.adaptation-fund.org/wp-content/uploads/2019/04/45276784165_9595bd2646_o-002-1-e1554490680122.jpg", "https://guardian.ng/ama-press-releases/greta-thunberg-speaks-for-africa-when-it-comes-to-climate-where-are-africas-voices/"),
            const SizedBox(height: 30,),
            imgAdds("https://www.voicesofyouth.org/sites/voy/files/images/2021-04/copy_of_untitled_5.gif"),
              const SizedBox(height: 30,),
            img(context, "'Insecurity, climate change slowing down Nigeria's food sufficiency drive'", "https://media.nationalgeographic.org/assets/photos/242/882/b6b960a9-c744-4703-a2cc-a67b22296414.jpg", "https://guardian.ng/features/agro-care/insecurity-climate-change-slowing-down-nigerias-food-sufficiency-drive"),
            const SizedBox(height: 30,),
            img(context, "Earth Day: Nigerian youth contribute to climate justice", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD6ZMwRmwNCewDCwVLlUKgxUf_pyvu37dJQA&usqp=CAU", "https://www.lutheranworld.org/news/earth-day-nigerian-youth-contribute-climate-justice"),
            const SizedBox(height: 30,),
            imgAdds("https://upload.wikimedia.org/wikipedia/commons/a/ae/63_years_of_climate_change_by_NASA.gif"),
            const SizedBox(height: 30,),
            img(context, "AfDB plans Africa's climate finance increment to 25bn", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4HBx0mMG1Yj4IgdSEJpTMYtTSCE-TLpy1-Q&usqp=CAU", "https://punchng.com/afdb-plans-africas-climate-finance-increment-to-25bn/"),
              
            ],
          ),
        ),
        
            ])))
    );
  }



  Container img(BuildContext context, String title, String imageurl, String url){
    return Container(
      padding: const EdgeInsets.only(
          left: 17.0, right: 17.0, top: 17.0, bottom: 17.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 381,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              imageurl,
              fit: BoxFit.fitWidth,
              width: double.maxFinite,
              height: 225,
              loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return SizedBox(
                  height: 225,
                  child: Center(
                    child: CircularProgressIndicator(
                    color: const Color.fromARGB(255, 124, 123, 120),
                    value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                      ),
                    ),
                  );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
           const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Container()),
              RaisedButton(
                padding: const EdgeInsets.all(20),
                textColor: Colors.green,
                color: Colors.white,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Webview(url))),
                child: const Text('View>>>'),
              ),
            ],
          ),
        ],
      ),
    );
  }



Text appText(String text, double size, FontWeight weight){
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }



Image imgAdds(String url){
  return Image.network(
    url,
    fit: BoxFit.fitWidth,
    width: double.maxFinite,
    height: 100,
    loadingBuilder: (BuildContext context, Widget child,
      ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return SizedBox(
        height: 100,
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


