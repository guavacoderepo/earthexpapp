import 'dart:io';
// import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
// import 'dart:html';
import '../models/shareddata.dart';



class postarticle extends StatefulWidget {
  const postarticle({ Key? key }) : super(key: key);

  @override
  State<postarticle> createState() => _postarticleState();
}

class _postarticleState extends State<postarticle> {
  final _title = TextEditingController();
  final _articlebody = TextEditingController();

  var shared  = SharedData();

  bool isLoading = false;
  bool imgLoading = false;

  String imageUrl  =  "";
  String head = " ";

  int value  =  0;
  String profileImage = ""; 



   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
   File? _photo;
    final ImagePicker _picker = ImagePicker();

    Future imgFromGallery() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _photo = File(pickedFile.path);
        } else {
          // print('No image selected.');
        }
      });
      uploadFile();
    }



    Future uploadFile() async {
      if (_photo == null) return;
    
        final fileName = basename(_photo!.path);
        final destination = 'articlesImg/$fileName';

        try {
          imgLoading = true;
          final ref = firebase_storage.FirebaseStorage.instance
              .ref(destination)
              .child('articlesImg/');
          
          String url = await (await ref.putFile(_photo!)).ref.getDownloadURL();

          setState(() {
            imageUrl  = url;
            imgLoading = false;
          });

        }catch(e){
          rethrow;
        }
    }

   Future post() async{
    String time = DateFormat("hh-mm").format(DateTime.now());
    String date = DateFormat("dd-mm-yyyy").format(DateTime.now());
    

    try{
      
      final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/articles.json");
      http.post(url, body: json.encode(
        {
          "Username": this.head,
          "Title": _title.text,
          "Body": _articlebody.text,
          "Liked":"0",
          "ImageUrl": imageUrl,
          "Time": time,
          "Date": date,
        }
      ),
      );
      setState(() {
        isLoading = false;
        _title.clear();
        _articlebody.clear();
      });
      
    }catch(err){
      // print("error");
    }
  }




  @override
  void initState() {
    
    shared.loadperfString().then((String name) {
        setState(() {
          this.head  = name;
        });
      });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EarthExp', style: TextStyle(color: Colors.green), ),
         backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.green,)
          ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: isLoading? 
        const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 6,
          ),
        )
      :ListView(
        children: [
          Container(
        padding: const EdgeInsets.all(30),
      child: Column(
        children: [

          Center(
            child: imageUrl.isNotEmpty?
            Image.network(imageUrl, width: 150,height: 150,):
            Container(), 
            
          ),

          Center(
            child: imgLoading?
            const CircularProgressIndicator(
              strokeWidth: 6,
            ):
            Container(),
            
          ),

          

          
          const SizedBox(height: 30,),
          
          TextFormField(
            decoration: const InputDecoration(

              label: Text("Article title"),

            ),
            
            controller: _title,
          ),
          const SizedBox(
            height: 30,
          ),
          // username
          TextFormField(
            decoration: const InputDecoration(
            hintText: "Enter an Article",
            // fillColor: Color.fromARGB(255, 184, 172, 172),
            // filled: true,
                          
            ),
            maxLines: 10,
            
            controller: _articlebody,
          ),
          
          const SizedBox(
            height: 30,
          ),

          // Email
          ElevatedButton(
            onPressed: imgFromGallery, 
            child: const Text("Select an image"),
            ),
          const SizedBox(
            height: 30,
          ),

          imageUrl.isEmpty?
          const ElevatedButton(
            onPressed: null, child:
           Text(
              "Post",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            )
          :ElevatedButton(
            onPressed: () 
            
            {
              if(_title.text.isEmpty || _articlebody.text.isEmpty){
                const snackBar = SnackBar(content: Text("Empty Text Fields"),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }else{
                setState(() {
                  isLoading = true;
                });

                // uploadFile();
                post();
                
                
                const snackBar = SnackBar(content: Text("Upload successful"),);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }, 
            
            child: const Text(
              "Post",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            
            
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
              shadowColor: const Color.fromARGB(255, 78, 73, 72),
              // onPrimary: Color.fromARGB(222, 253, 253, 253),
              primary: const Color.fromARGB(222, 50, 139, 55),
            ),
          ),
          
          
        ]
      ),
      )
      ],
      )
    );
    
  }


}
