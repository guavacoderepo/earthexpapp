import 'package:earthexpapp/screens/feeds.dart';
import 'package:earthexpapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/shareddata.dart';
// import 'dart:html';

class register extends StatefulWidget {
  const register({ Key? key }) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  
  final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/users.json");

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pwd1 = TextEditingController();
  final _pwd2 = TextEditingController();
  final _uname = TextEditingController();

  List<String> user = [];
  bool isLoading = false;

  var shared = SharedData();
  // String value  =  "";

  Future write() async{
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((id, Data) {
        user.add(Data["Username"]);
      });

      if(user.contains(_uname.text)){
        const snackBar = SnackBar(content: Text("Username Taken"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _pwd1.clear();
        _pwd2.clear();
        _uname.clear();
      }else{
        http.post(url, body: json.encode(
        {
          "Name": _name.text,
          "Email": _email.text,
          "Username": _uname.text,
          "Password":_pwd1.text
        }
      ),
      );
        shared.savevarpef(_name.text);
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => const Login()),
      );
      }
    
      isLoading = false;
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
      // print("back pressed");
      return true;
    }, 
  
  
    child: Scaffold(
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
                 const SizedBox(
                  height: 10,
                ),


                  // text
                const Text(
                  'Welcome to EarthExp!',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'GoogleFont',
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.only(left: 40,right: 40, top: 10,),
                    child: Column(
                      children: [
                        // full name 
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_outlined),
                            // hintText: "Enter full name",
                            label: Text("Name"),
                            
                            // helperText: "Name must not be less than 5 chars",
                            // helperStyle: TextStyle(color: Colors.green),

                          ),
                          controller: _name,
                        ),
                        // username
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_rounded),
                            // hintText: "Enter full name",
                            label: Text("Username"),
                            // helperText: "username must not be less 5 than  chars",
                            // helperStyle: TextStyle(color: Colors.green),
                            
                          ),
                          controller: _uname,
                        ),

                        // Email
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            // hintText: "Enter full name",
                            label: Text("Email"),
                            // helperText: "Please enter a Valid Email Address",
                            // helperStyle: TextStyle(color: Colors.green),
                            
                          ),
                          controller: _email,
                        ),

                        // password
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            // hintText: "Enter full name",
                            label: Text("Password"),
                            // helperText: "Password must not be less 6 than  chars",
                            // helperStyle: TextStyle(color: Colors.green),
                            
                          ),
                          obscureText: true,
                          controller: _pwd1,
                        ),

                        //confirm password
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            // hintText: "Enter full name",
                            label: Text("Confirm Password"),
                            // helperText: "please confirm password",
                            // helperStyle: TextStyle(color: Colors.green),
                            
                          ),
                          controller: _pwd2,
                          obscureText: true,
                        ),

                        // registering button
                        const SizedBox(
                          height: 20,
                        ),


                        // on submit
                        ElevatedButton(
                          onPressed: (){
                            if(_name.text.isEmpty || _uname.text.isEmpty || _email.text.isEmpty || _pwd1.text.isEmpty || _pwd2.text.isEmpty){
                              const snackBar = SnackBar(content: Text("Empty Text Fields"),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else if(_pwd1.text != _pwd2.text){
                              const snackBar = SnackBar(content: Text("Incorrect Password"),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              _pwd1.clear();
                              _pwd2.clear();
                            }else if (_pwd1.text.length<6 && _pwd2.text.length<6){
                              const snackBar = SnackBar(content: Text("Password must not be less than 6 characters"),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              _pwd1.clear();
                              _pwd2.clear();
                            }else{
                             setState(() {
                                isLoading = true;
                             });
                              write();
                              
                            }
                            
                          }, 
                          
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 18,
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
                                  const Text("Already have an account? "),
                                  InkWell(
                                    child: const Text("Signin", style: TextStyle(color: Colors.red),),
                                    onTap: (){
                                       Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => const Login()));
                                    } ,
                                    // mouseCursor: MouseCursor.defer,

                                    )
                                ],
                              ),

                              Row(
                                children: const [
                                  Checkbox(
                                    value: true, 
                                    onChanged: null,
                                    ),
                                    Text("Recieve push notifications")
                                ],
                              ),
                              Row(
                                children: const[
                                  Checkbox(
                                    value: false, 
                                    onChanged: null,
                                    ),
                                    Text("I agree with TDB!s privacy policy")
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