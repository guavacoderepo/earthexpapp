import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class database{

  List<String> articlebody = [];
  List<String> date = [];
  List<String> time = [];
  List<String> user = [];
  List<String> titles = [];
  List<String> imageurl = [];



  Future<void> readData() async {
      
     final url = Uri.parse("https://earthexp-8259f-default-rtdb.firebaseio.com/articles.json");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      if (extractedData.isEmpty) {
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
      
      
    } catch (error) {
      rethrow;
    }
  }
}





















