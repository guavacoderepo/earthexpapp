import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 late  TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: 'ACa4f2b780aaa07e8c5e70f8903e5c50ca', authToken: '45f8ada92e656880b601a4c8005b2807', twilioNumber: '+19705405230');

    super.initState();
  }

  void sendSms() async {
    twilioFlutter.sendSMS(toNumber: '+2348138327949', messageBody: 'hello world');
  }

  void sendWhatsApp() {
    twilioFlutter.sendWhatsApp(toNumber: '', messageBody: 'hello world');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);

    await twilioFlutter.getSMS('***************************');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sms"),
      ),
      body: Center(
        child: Text(
          'Click the button to send SMS.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}