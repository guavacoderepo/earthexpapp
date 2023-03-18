import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:html';

class SharedData{

  Future <int> loadperfint() async{
  SharedPreferences perfs = await SharedPreferences.getInstance();
  int val = perfs.getInt("page") ?? 0; 
  return val; 
}

Future <String> loadperfString() async{
  SharedPreferences perfs = await SharedPreferences.getInstance();
  String name = perfs.getString("name") ?? "";
  return name; 
}

Future removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("name");
}

saveperf(String name, int value) async{
  SharedPreferences perfs = await SharedPreferences.getInstance();
  perfs.setInt(name, value);
}

savevarpef(String name) async{
  SharedPreferences perfs = await SharedPreferences.getInstance();
  perfs.setString("name", name);
}




}