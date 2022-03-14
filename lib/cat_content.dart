import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import'dart:typed_data';
import 'constants.dart';
import 'package:http/http.dart' as http;


class CatContent extends StatefulWidget {
  @override
  _CatContentState createState() => _CatContentState();
}


class _CatContentState extends State<CatContent> {

  String url = 'https://cataas.com/cat/gif';
  String text = 'GET CAT DOSE';
  Widget _display = Image.asset('images/logo.png');
  Color buttonColor = kprimaryColorLight;
  Color textColor = ktextColor;
  bool isRetrieving = false;

  @override
  void initState() {
    _display = Image.asset('images/logo.png');
    super.initState();
  }

  void getData () async{
    //getData help us to find out if we are able to retrieve content from the url.
    http.Response response = await http.get(Uri.parse(url));
    response.statusCode == 200 ? isRetrieving = true : isRetrieving = false;
  }

  _updateCat() async{
    //updateCat help us update the image we display on screen.
    //if we're successfully retrieving from the given url, it displays the app's
    //Logo and a linear progress indicator while it loads the next cat GIF.
    setState(() {
      buttonColor = kprimaryColorLight;
      textColor = ktextColor;
      _display = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/logo.png', scale: 2.0),
          const SizedBox(
            width: 250.0,
            child: LinearProgressIndicator(
              minHeight: 5.0,
              color: kcontrastColor,
              backgroundColor: kdarkcontrastColor,
            ),
          ),
        ],
      );
    });

    getData();

    if (isRetrieving = false){
      _display = Image.asset('images/sorry.jpeg');
    }
    else {
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
      setState(() {
        _display = Image.memory(bytes);
        text = 'TAP FOR MORE';
        textColor = ktextColor;
        buttonColor = kprimaryColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbaseColor,
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: _display,
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                _updateCat();
              },
              child: Card(
                elevation: 8.0,
                color: buttonColor,
                shadowColor: kprimaryColorDark,
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
                child: Center(
                  child: Text(text,
                    style: TextStyle(
                      color: textColor,
                      fontFamily:'Gluten',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
