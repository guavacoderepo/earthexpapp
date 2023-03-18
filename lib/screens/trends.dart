// import 'dart:html';

import 'package:flutter/material.dart';
import '../models/shareddata.dart';
import 'feeds.dart';
import 'utils.dart';
import 'webview.dart';



class trends extends StatefulWidget {
  const trends({ Key? key }) : super(key: key);

  @override
  State<trends> createState() => _trendsState();
}

class _trendsState extends State<trends> {

  int select = 1;
  bool isLoading = true;
  String value  =  "";
  var util = utils();
  var shared = SharedData();
  String read = " ";
  String url  = " ";


  final listitem = [
    "https://www.ourendangeredworld.com/wp-content/uploads/2020/12/There-is-No-Planet-B-Polar-Bear.jpg.webp",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmITRsvA1ff3wQZ7xEqIXhUZgTqz74ny0UPvEgomHIR2yMP11dth12dCDW8DoR0U4ufMk&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYiL0m23xb0aXYCz3CkV_lBcZs8DxUMOIkNA&usqp=CAU",
    "https://creativereview.imgix.net/content/uploads/2020/04/TsieskeClark.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE7tiq-gvzm8qS_RkAyi6OrnPkfRL3JSYKtLWITisKmLzaIC_vE2zVvIAqLot5TtRgGzs&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgFQ43O_3LCSZQAA-Zw58RuGKmjfJecP2NF_X3IdD80Ik1lUBPnBt6NQ9c11jwEzKo2Ok&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpC-bKmGHjcQObik-UxMLGu_ks04j4yGABg7kZU-vhAANrat2yd8jwvMjORpIoOOauvyI&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfjbsDJFAN3EvaHpPMD_LMlY7QK3ClusKrMQ&usqp=CAU",
    "https://static.vecteezy.com/system/resources/previews/004/308/980/original/global-warming-poster-vector.jpg",
    "https://images.squarespace-cdn.com/content/v1/5ae226e1ee175988a09f3d7e/1582749188151-Q149UF18NTBXITHBPK01/2018-36-KW.jpg?format=1000w",
    "https://i0.wp.com/coolhunting.com/wp-content/uploads/2019/08/stopclimatemelt.jpg?fit=700%2C700&ssl=1",
    "https://media.istockphoto.com/vectors/global-warming-with-deforestation-on-earth-vector-id1187594222?k=20&m=1187594222&s=612x612&w=0&h=r2dBYNiJ9nJq4p2DHN6JO_NtAqxSU5z5go0IGr_4YL8=",
  ];

  final urls = [
    // "Makes the complexities of planet-scale economic and environmental interconnectivity fun.",
    "https://users.ox.ac.uk/~sfop0060/pdf/Thunberg.pdf",
    "https://www.csuchico.edu/bic/_assets/documents/bill-gates.pdf",
    "http://prima.lnu.edu.ua/faculty/geology/phis_geo/fourman/library-Earth/Climate%20change%20observed%20impacts%20on%20planet%20Earth.pdf",
    "https://hostnezt.com/cssfiles/currentaffairs/internationalmagazines/The_Future_We_Choose_Surviving_the_Climate_Crisis.pdf",
    "https://r.jordan.im/download/ethics/Stuart2020_Article_RadicalHopeTruthVirtueAndHopeF.pdf",
    "https://users.ox.ac.uk/~sfop0060/pdf/Thunberg.pdf",
    "https://www.csuchico.edu/bic/_assets/documents/bill-gates.pdf",
    "http://prima.lnu.edu.ua/faculty/geology/phis_geo/fourman/library-Earth/Climate%20change%20observed%20impacts%20on%20planet%20Earth.pdf",
    "https://hostnezt.com/cssfiles/currentaffairs/internationalmagazines/The_Future_We_Choose_Surviving_the_Climate_Crisis.pdf",
    "https://r.jordan.im/download/ethics/Stuart2020_Article_RadicalHopeTruthVirtueAndHopeF.pdf",
    "https://r.jordan.im/download/ethics/Stuart2020_Article_RadicalHopeTruthVirtueAndHopeF.pdf",
    "https://users.ox.ac.uk/~sfop0060/pdf/Thunberg.pdf",
  ];

  _onWillPop(){
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => const feeds()));
  }


@override
  void initState() {
    super.initState();
    shared.loadperfString().then((String name) {
      setState(() {
        this.value  = name;
      });
    });
    
  }



  @override
  Widget build(BuildContext context)  => WillPopScope(
    
    onWillPop: () async{
      // print("back pressed");
      return _onWillPop();
    }, 
  
  
    child:  Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: util.appBar(),

      bottomNavigationBar: bottomnav(select),

      endDrawer: util.drawer(context, value),


      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(listitem.length, (index) {
          return Center(child: image(context, listitem[index], urls[index]));
        }),
      ),

    ),
  );
}



Container image(BuildContext context, String Imagename, String url) {
  
  return Container(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(5),
    child: InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Webview(url))),
      child: Image.network(
        Imagename,
        fit: BoxFit.fitHeight,
        width: double.maxFinite,
        loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
                ),
              );
            },
      ),
    ),
  );
}
