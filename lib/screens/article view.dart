import 'package:flutter/material.dart';
import 'package:earthexpapp/screens/article.dart';
import 'package:earthexpapp/models/shareddata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:html';



class ViewPage extends StatefulWidget {
  const ViewPage({ Key? key }) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  var shared  = SharedData();

  List<String> articlebody = [];
  List<String> date = [];
  List<String> time = [];
  List<String> user = [];
  List<String> titles = [];
  List<String> imageurl = [];
  
  bool isLoading = true;
  int value  =  0;
  String profileImage = ""; 
  Map profileData = {};

  String read = " ";
  String head = " ";

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
      });
      setState(() {
        isLoading = false;
        read = titles[value];
      });
      
    } catch (error) {
      throw error;
    }
  }


  
      





 @override
  void initState() {
    
    shared.loadperfint().then((int val) {

      if(this.value  != 0){
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => const article()));
      }else{
        shared.loadperfString().then((String name) {
        setState(() {
          this.head  = name;
          this.value  = val;
        });
      });
      }
    }); 
    readData(); 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
      title:  Text(read, style: const TextStyle(color: Colors.green),),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.green,)
          ),
      ),
      
      body: isLoading
        ? const Center(

          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 6,
          ),
          
      ) :
      ListView(
        children: [
          Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Image.network(
              imageurl[value],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20,),
            
            Text(
              articlebody[value],
               style: const TextStyle(
                fontSize: 18,
                // fontFamily: 'GoogleFont',
                color: Colors.black87,
                fontWeight: FontWeight.w200,
                
              ),
              textAlign: TextAlign.justify,
            ),


            const SizedBox(height: 50,),
            const Text(
              "More related Articles",
                style: TextStyle(
                fontSize: 25,
                
                // fontFamily: 'GoogleFont',
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                
              ),
              textAlign: TextAlign.justify,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  appText(titles[2], 20),
                  Image.network(
                    imageurl[2],
                    
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    height: 120,
                    
                  ),
                  appText("${time[2]}${date[2]}", 15),
                  const SizedBox(height: 20,),

                  appText(titles[4], 20),
                  Image.network(
                    imageurl[4],
                    
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    height: 120,
                    
                  ),
                  appText("${time[4]}${date[4]}", 15),
                  const SizedBox(height: 20,),


                  appText(titles[6], 20),
                  Image.network(
                    imageurl[6],
                    
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    height: 120,
                    
                  ),
                  appText("${time[6]}${date[6]}", 15),
                  const SizedBox(height: 20,),

                  appText(titles[3], 20),
                  Image.network(
                    imageurl[3],
                    
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                    height: 120,
                    
                  ),
                 appText("${time[3]}${date[3]}", 15),
                  const SizedBox(height: 20,)
                ],
              ),
              
              )

        ]
        ),
      )
        ],
      )
      
    );
  }
}


Text appText(String text, double size){
  return  Text(
    text,
      style: TextStyle(
      fontSize: size,
      // fontFamily: 'GoogleFont',
      color: Colors.black87,
      fontWeight: FontWeight.w200,
      
    ),
    textAlign: TextAlign.justify,
  );
}

