// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'utils.dart';
// import 'dart:html';

class FootPrint extends StatefulWidget {
  const FootPrint({ Key? key }) : super(key: key);

  @override
  State<FootPrint> createState() => _FootPrintState();
}

class _FootPrintState extends State<FootPrint> {

  TextEditingController electricity = TextEditingController();
  TextEditingController gas = TextEditingController();
  TextEditingController oil = TextEditingController();
  TextEditingController car = TextEditingController();
  TextEditingController longflight = TextEditingController();
  TextEditingController train = TextEditingController();
  TextEditingController shortflight = TextEditingController();

  bool tinState = false;
  bool newspaperState = false;

  double tin = 0;
  double newspp = 0;

  var util = utils();


  Future calculate() async{

    if(electricity.text.isNotEmpty && gas.text.isNotEmpty && car.text.isNotEmpty && oil.text.isNotEmpty && shortflight.text.isNotEmpty && longflight.text.isNotEmpty && train.text.isNotEmpty){
      double summation = (double.parse(electricity.text )* 105)+ (double.parse(gas.text ) * 105)+ (double.parse(oil.text )*133) + (double.parse(car.text )*0.79) + (double.parse(shortflight.text)*1100) + (double.parse(longflight.text )*4400) + (double.parse(train.text)*1100);

      if(newspaperState == false){newspp = 0;}else{newspp = 184;}
      if(tinState == false){tin = 0;}else{tin = 166;}

      double total  = tin + newspp + summation;
      // print(summation);

      var snackBar = SnackBar(content: Text("Your carbon foot print is ${total} tons of Co2 per year"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      electricity.clear();
      gas.clear();
      oil.clear();
      car.clear();
      shortflight.clear();
      longflight.clear();
      train.clear();
    }else{
      var snackBar = const SnackBar(content: Text("Empty fields"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    

    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
      title: const Text(
        'Calculate Carbon FootPrint', 
        style: TextStyle(color: Colors.green),
      ),

        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.green,)
          ),
      ),
      body: ListView(
        
        children: [
          
          Container(
            
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 20,),
                

      
                // SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "How much electricity do you use a month in KWat/Hr?",
                    hintText: "hint: 0.25",
                  ),
                  controller: electricity,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"How much natural gas do you use in therm?",
                    hintText: "hint: 0.03",
                    
                  ),
                  controller: gas,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"How much oil do you use in a month in litres?",
                    hintText: "hint: 12",

                  ),
                  controller: oil,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"What is the total milage you use yearly by car in Km?",
                    hintText: "hint: 95",

                  ),
                  controller: car,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"How many short flights do you take each year(4 hours or less) Km?",
                    hintText: "hint: 4",

                  ),
                  controller: shortflight,
                  keyboardType: TextInputType.number,
                ),


                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"How many long flights do you take each year(4 hours or more) in Km?",
                    hintText: "hint: 2",
                  ),
                  controller: longflight,
                  keyboardType: TextInputType.number,
                ),
                
                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText:"How much do you travel by inter-city rail each year in Km?",
                    hintText: "hint: 34",

                  ),
                  controller: train,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Text("Do you recycle Aluminum and Tin?"),
                    Checkbox(
                      value: this.tinState,
                      onChanged: (bool? value){
                        // print(this.tinState);
                      setState(() {
                        this.tinState = value!;
                      });
                      }
                      
                    ),
                  ],
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    const Text("Do you recycle newspappers?"),
                    Checkbox(
                      value: this.newspaperState,
                      onChanged: (bool? value){
                        // print(this.newspaperState);
                        setState(() {
                          this.newspaperState = value!;
                        
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15,),

                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                  onPressed: calculate,
                  color: Colors.green,
                  child: const Text("Submit", style: TextStyle(color: Color.fromARGB(255, 245, 247, 245)),),
                ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}


