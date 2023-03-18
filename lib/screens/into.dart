
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainPage(),
    );
  }
}
class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}
class _mainPageState extends State<mainPage> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
          image: Image.asset("images/livedemo.png"),
          title: "Live Demo page 1",
          body: "Welcome to Proto Coders Point",
          footer: const Text("Footer Text here "),
          decoration: const PageDecoration(
            pageColor: Colors.blue,
          )),
      PageViewModel(
        image: Image.asset("images/visueldemo.png"),
        title: "Live Demo page 2 ",
        body: "Live Demo Text",
        footer: const Text("Footer Text  here "),
      ),
      PageViewModel(
        image: Image.asset("images/demo3.png"),
        title: "Live Demo page 3",
        body: "Welcome to Proto Coders Point",
        footer: const Text("Footer Text  here "),
      ),
      PageViewModel(
        image: Image.asset("images/demo4.png"),
        title: "Live Demo page 4 ",
        body: "Live Demo Text",
        footer: const Text("Footer Text  here "),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Introduction Screen"),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        showNextButton: true,
        showSkipButton: true,
        skip: const Text("Skip"),
        done: const Text("Got it "),
        onDone: () {},
      ),
    );
  }
}