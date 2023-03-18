// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:earthexpapp/models/shareddata.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';



class profile extends StatefulWidget {
  const profile({ Key? key }) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {


  var shared  = SharedData();
  
  List<String> Email = [];
  List<String> Name = [];
  List<String> Username = [];
  List<String> user = [];
  String imageUrl  =  "";

  int value  =  0;
  String profileImage = ""; 
  
  String head  =  "";

  bool isLoading = true;

  Future<void> readData() async {
     final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/users.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((id, Data) {
        Username.add(Data["Username"]);
        Email.add(Data["Email"]);
        Name.add(Data["Name"]);
      });

      setState(() {
        value = Username.indexOf(head).toInt();
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }




  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

    File? _photo;
    final ImagePicker _picker = ImagePicker();

    Future imgFromGallery() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _photo = File(pickedFile.path);
          uploadFile();
        } else {
          // print('No image selected.');
        }
      });
    }


    Future imgFromCamera() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _photo = File(pickedFile.path);
          uploadFile();
        } else {
          // print('No image selected.');
        }
      });
    }

    Future uploadFile() async {
      if (_photo == null) return;
      final fileName = basename(_photo!.path);
      final destination = 'files/$fileName';

      try {
        final ref = firebase_storage.FirebaseStorage.instance
            .ref(destination)
            .child('file/');
        
         String url = await (await ref.putFile(_photo!)).ref.getDownloadURL();
         setState(() {
          imageUrl  = url;
         });


         await FirebaseFirestore.instance
          .collection("profile")
          .doc(this.head)
          .set({
            "Image": imageUrl,
            // "Username": head,


          },
        );

        final urllink = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/profileImges.json");
          http.post(urllink, body: json.encode(
            {
              "ImageUrl": imageUrl,
              "nickname": this.head,
            }
          ),
          );
          
        
        getimage();
        
      } catch (e) {
        // print('error occured');
      }
    }


    Future getimage() async{
      final result = await FirebaseFirestore.instance
      .collection("profile")
      .doc(this.head)
      .get();

      if(result.exists){
        
        setState(() {
        profileImage = result.get("Image").toString();
      });

      } else{
        profileImage = "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png";
      }
    }
      

  
  @override
  void initState() {
    super.initState();
    readData();
    shared.loadperfString().then((String name) {
      setState(() {
        this.head  = name;
        
      });
      getimage();
    });  
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
      title:  Text(
        head.toUpperCase(), 
        style: const TextStyle(color: Colors.green),
      ),

        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.green,)
          ),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: isLoading
        ? const Center(

          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 6,
          ),
          
      ):
      Container(
        margin: const EdgeInsets.all(50),
        padding: const  EdgeInsets.fromLTRB(30, 90, 30, 10),
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 136, 135, 132), )
        ),

        child: Column(
          children: [
            
            CircleAvatar(
              radius: 55,
              backgroundColor: const Color.fromARGB(255, 189, 187, 182),
              backgroundImage: NetworkImage(profileImage),
              
              
            ),
            const SizedBox(height: 40,),

            Row(
              children: [
                appText("Name:  ", 20),
                appText(Name[value], 20),
              ],
              ),
                const SizedBox(height: 40,),

              Row(
                children: [
                  appText("Email:  ", 20),
                  appText(Email[value], 20),
                ],
              ),
                const SizedBox(height: 40,),
              Row(
                children: [
                  appText("Username:  ", 20),
                  appText(Username[value], 20),
                ],
              ),
              // RaisedButton(onPressed: getimage),
              const SizedBox(height: 40,),

              GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xffFDCF09),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 150,
                  height: 105,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      
    );
  }



  
  void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Gallery'),
                        onTap: () {
                          imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Camera'),
                      onTap: () {
                        imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                   
                  ],
                ),
              ),
            );
        }
      );
  }
  
}

Text appText(String text, double size){
  return Text(
    text,
    style:TextStyle(
      fontSize: size,

    )
  );
}