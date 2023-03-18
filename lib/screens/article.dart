// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:earthexpapp/screens/feeds.dart';
import 'package:earthexpapp/screens/post articles.dart';
import '../models/shareddata.dart';
import 'article view.dart';
import 'dart:convert';
import 'utils.dart';
// import 'dart:html';


class article extends StatefulWidget {
  const article({ Key? key }) : super(key: key);

  





  @override
  State<article> createState() => _articlesState();
}

class _articlesState extends State<article> {

  int select = 3;
  var util = utils();
  var shared  = SharedData();
  
  
  List<String> articlebody = [];
  List<String> date = [];
  List<String> time = [];
  List<String> user = [];
  List<String> titles = [];
  List<String> imageurl = [];
  List<String> liked = [];
  int len  = 0; 
  String value  =  "";
  String profileImage = ""; 
  List<String> nickname = [];
  List<String> profilelist = [];

  
  bool isLoading = true;
  final bool _isLiked = false;
  List<String> list = [];

  Future<void> readData() async {
      
     final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/articles.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((id, Data) {
        user.add(Data["Username"]);
        titles.add(Data["Title"]);
        articlebody.add(Data["Body"]);
        imageurl.add(Data["ImageUrl"]);
        time.add(Data["Time"]);
        date.add(Data["Date"]);
        liked.add(Data["Liked"]);
      });
      // print(extractedData);
      setState(() {
        len  = extractedData.length.toInt() ; 
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
    // print(extractedData);
  }



   Future getimage() async{

    final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/aprofileImges.json");
    try {
      final response = await http.get(url);
      final profileData = json.decode(response.body) as Map<String, dynamic>;
      
      if (profileData == null) {
        return;
      }
      profileData.forEach((id, img) {
        nickname.add(img["nickname"]);
        profilelist.add(img["ImageUrl"]);
      });

    } catch (error) {
      rethrow;
    }
  }

  _onWillPop(){
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => const feeds()));
  }


  
  @override
  void initState() {
    // print(d4);
    super.initState();
    readData();
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
  
  
    child:  Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),

      appBar: util.appBar(),

      bottomNavigationBar: bottomnav(select),


      endDrawer: util.drawer(context, value), 

      
      body: isLoading
            ? Center(

              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.green,
                strokeWidth: 6,
              ),
          ) 
        :RefreshIndicator(
          child:
        ListView.builder(
        itemCount: len,
        
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            child: Container(
              color: Colors.white,
            margin: const EdgeInsetsDirectional.all(10),
            padding: const EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 5),

            height: 300,
            

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.withOpacity(0.5),
                      image: DecorationImage(
                        image: nickname.contains(user[index])?

                        NetworkImage(nickname[nickname.indexOf(user[index]).toInt()]):
                        NetworkImage("https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png")
                        )
                    ),
                    
                  ),
                      const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          user[index],
                          // "Article by "+user[index],
                          style: const TextStyle(
                          fontSize: 20,
                          // fontFamily: 'GoogleFont',
                          color: Colors.black87,
                          fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(time[index] + " " + date[index], 
                        style: const TextStyle(
                          fontSize: 12,
                          // fontFamily: 'GoogleFont',
                          color: Color.fromARGB(66, 32, 31, 31),
                          fontWeight: FontWeight.w200,
                          ),
                        ),
                        
                        //  RaisedButton(onPressed: getimage),
                      ],
                    )
                  ],

                ),
              
                Image.network(
                  imageurl[index],
                  
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                  height: 140,
                  loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                          ),
                        );
                      },
                    ),
                            
                const SizedBox(height: 5,),
                
                Text(titles[index]),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // print(index);
                        
                        setState(() {
                        //null 
                      });}, 
                      icon: Icon(_isLiked? Icons.star : Icons.star_border),
                          color: Color.fromARGB(255, 82, 79, 79),
                    ),
                    IconButton(
                      onPressed: () {
                        // print(index);
                        
                        setState(() {
                        //null
                      });}, 
                      icon: Icon(_isLiked? Icons.star : Icons.book_online_outlined),
                          color: Color.fromARGB(255, 82, 79, 79),
                    ),
                    SizedBox(width: 5,),
                    Text(liked[index])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  // child:Container(
                  // height:1.5,
                  // width: MediaQuery.of(context).size.width,
                  // color:const Color.fromARGB(255, 175, 173, 173),),
                  
                ),
              ],
              ),
              
            ),
            onTap: (){
              shared.saveperf("page", index);
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => const ViewPage()));

            },
          );
        }
      ),
      onRefresh: () {
        return Future.delayed(
              Duration(seconds: 1),
              () {
                setState(() {
                  readData();
                });
 
                // showing snackbar
                
                
        });
      } 
    
    ),

      // bottom nav bar
     

      floatingActionButton: FloatingActionButton(
        
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => const postarticle(),
          ),
        );
        },
        backgroundColor: Color.fromARGB(255, 128, 129, 128),
        tooltip: "Add article",
        child: const Icon(Icons.add),
      ), 
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