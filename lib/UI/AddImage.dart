import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mental_health/Utils/SizeConfig.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool isLoading = false;
  var selectedphot = '';
  bool isError = false;
  @override
  void initState() {
    getfeaturedmatches();
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndexs;
  _onSelectedslot(int index) {
    setState(() {
      _selectedIndexs = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Image",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              children: images(),
            )),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: MaterialButton(
                onPressed: () {
                  print(selectedphot);
                  Navigator.of(context).pop(selectedphot.toString());
                },
                color: Color(0xFF0066B3),
                minWidth: SizeConfig.screenWidth,
                child: Text(
                  "Done",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Color(0xFF0066B3)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic cartdata = new List();
  void getfeaturedmatches() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(
        Uri.parse(
            "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/meta"),
      );
      print("ffvvvf");
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson);
        setState(() {
          cartdata = responseJson['event_images'];

          isLoading = false;
          print('setstate' + cartdata.toString());
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  List<Widget> images() {
    List<Widget> getimages = new List();
    for (int i = 0; i < cartdata.length; i++) {
      getimages.add(GestureDetector(
        onTap: () {
          _onSelectedslot(i);
          setState(() {
            selectedphot = cartdata[i];
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
                      cartdata[i]),
              fit: BoxFit.fitHeight,
            )),
            child: Container(
              alignment: Alignment.topRight,
              child: Visibility(
                  visible: _selectedIndexs == i ? true : false,
                  child: CircleAvatar(radius: 15, child: Icon(Icons.check))),
            ),
          ),
        ),
      ));
    }
    return getimages;
  }
}
