import 'package:flutter/material.dart';
import 'dart:math' as math;

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  BoundingBox(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
  );

  String type = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBox() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }


        if(re["detectedClass"] == "car" ||
        re["detectedClass"] == "motorcycle" ||
        re["detectedClass"] == "airplane" ||
        re["detectedClass"] == "train" ||
        re["detectedClass"] == "person" ||
        re["detectedClass"] == "television" ||
        re["detectedClass"] == "phone" ||
        re["detectedClass"] == "laptop" ||
        re["detectedClass"] == "mouse" ||
        re["detectedClass"] == "bus" ||
        re["detectedClass"] == "truck" ||
        re["detectedClass"] == "refrigerator" ||
        re["detectedClass"] == "boat" ||
        re["detectedClass"] == "tv" ||
        re["detectedClass"] == "fire hydrant"){
          type = "CO2 Emitter  ";
        }else{
          type = "Non CO2 Emitter  ";
        }


        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 5, 241, 56),
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} $type ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Color.fromARGB(255, 4, 243, 36),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    return Stack(
      children: _renderBox(),
    );
  }
}
