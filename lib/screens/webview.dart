// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Webview extends StatefulWidget {
  String url;
  Webview(this.url, {Key? key}) : super(key: key);


  @override
  State<Webview> createState() => _WebviewState(url);
}

class _WebviewState extends State<Webview> {
  
  String url;
  _WebviewState(this.url);

  @override
  Widget build(BuildContext context) {
    return WebView(
       initialUrl: url,
       javascriptMode: JavascriptMode.unrestricted,
     );
  }
}