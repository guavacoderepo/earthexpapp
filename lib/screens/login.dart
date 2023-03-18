import 'dart:io';

import 'package:earthexpapp/screens/feeds.dart';
import 'package:earthexpapp/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/shareddata.dart';
// import 'dart:html';


class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var shared = SharedData();
  final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/users.json");

  List<String> user = [];
  List<String> pwd = [];
  final _pwd = TextEditingController();
  final _uname = TextEditingController();
  bool isLoading = false;
  bool view = true;

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
                shared.savevarpef("");
                Navigator.of(context).pop(true);
                exit(0);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      )
      
      ) ??
      false;
    }


  Future read() async{
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      

      extractedData.forEach((id, data) {
        user.add(data["Username"]);
        pwd.add(data["Password"]);
      });


      if(user.contains(_uname.text)){
        int u = user.indexOf(_uname.text).toInt();
        int p = pwd.indexOf(_pwd.text).toInt();

        if(u==p){
          shared.savevarpef(_uname.text);
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => const feeds()));

          // setState(() {
          //   isLoading = false;
          // });
          
        }else{
          const snackBar = SnackBar(content: Text("Incorrect Username or password"),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          setState(() {
            isLoading = false;
          });

        }
      }else{
        const snackBar = SnackBar(content: Text("Incorrect Username or password"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }

    
      
    }catch(err){
      // print("error");
    }
  }



  @override
  void initState() {
    super.initState();
    
    // shared.loadperfString().then((String name) {
    //   if(name  != ""){
    //     Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => const feeds()));
    //   }
    // });
    
  }


  @override
   Widget build(BuildContext context)  => WillPopScope(
    
    onWillPop: () async{
      return _onWillPop();       
    }, 
  
  
    child:Scaffold(
      body: isLoading ?
      const Center(

          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 6,
          ),
      ) :
      ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                
                // image 
                Image.asset(
                  "images/logo.png",
                  width: 200,
                  height: 200,

                  ),
                


                  // text
                
                  
                  Container(
                    
                    padding: const EdgeInsets.only(left: 40,right: 40, top: 20, bottom: 20),
                    margin: const EdgeInsets.only(top: 0, left: 20, right: 20,),
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 214, 245, 144),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [


                        const Text(
                        'Welcome to EarthExp!',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'GoogleFont',
                            color: Colors.black87,
                            fontWeight: FontWeight.w900,
                            ),
                          ),
                        // full name 
                        
                        // username
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_rounded),
                            // hintText: "Enter full name",
                            label: Text("Username"),
                            
                          ),
                          controller: _uname,
                        ),

                        

                        // password
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            // suffixIcon: Icon(),
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                view =! view;
                              });
                            }, icon: const Icon(Icons.remove_red_eye)),

                            // hintText: "Enter full name",
                            label: const Text("Password"),
                            
                          ),
                          obscureText: view,
                          controller: _pwd,
                        ),

                        

                        // registering button
                        const SizedBox(
                          height: 20,
                        ),


                        // on submit
                        ElevatedButton(
                          onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(
                            // builder: (context) => const article()));

                            if(_uname.text.isEmpty || _pwd.text.isEmpty ){
                              const snackBar = SnackBar(content: Text("Empty Text Fields"),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else{
                              setState(() {
                                isLoading = true;
                              });
                              read();
                              
                            }
                            
                          }, 
                          
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          
                          
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(left:100, right: 100, top: 15, bottom: 15),
                            shadowColor: const Color.fromARGB(255, 78, 73, 72),
                            // onPrimary: Color.fromARGB(222, 253, 253, 253),
                            primary: const Color.fromARGB(222, 47, 117, 23),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Create a new account "),
                                  InkWell(
                                    child: const Text("Signup", style: TextStyle(color: Colors.red),),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const register()));

                                    },
                                    // mouseCursor: MouseCursor.defer,

                                    )
                                ],
                              ),
                            ],
                          ),

                        )

                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    )
  );
  }
