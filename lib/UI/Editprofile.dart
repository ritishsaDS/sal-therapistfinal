import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_health/UI/MyProfile.dart';
import 'package:mental_health/Utils/ActionSheet.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/Dialogs.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/data/repo/Updatetherapistprofile.dart';
import 'package:mental_health/data/repo/UploadImagesRepo.dart';
import 'package:mental_health/data/repo/UploadImagesprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeMain.dart';

class Editprofile extends StatefulWidget {
  String firstname;
  String lastname;
  var price;
  var gender;
  String image;
  String email;
  String phone;
  String experience;
  String photo;
  String multiplesession;
  Editprofile(
      {this.phone,
        this.multiplesession,
      this.photo,
      this.firstname,
      this.lastname,
      this.price,
      this.image,
      this.gender,
      this.email,
      this.experience});
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  GlobalKey<FormState> nameForm = GlobalKey<FormState>();
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var createUser = Updatetherapistprofile();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController email = TextEditingController();
  FocusNode firstNameFocusNode;
  FocusNode lastNameFocusNode;

  bool selected = false;
  bool filledFn = false;
  bool filledLn = false;
  String radioValue = "";
  var type;
  var uploadImage = UploadImagesProfileRepo();
  @override
  void initState() {
    // TODO: implement initState
    print(widget.gender);
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    firstNameController = TextEditingController(text: widget.firstname);
    lastNameController = TextEditingController(text: widget.lastname);
    email = TextEditingController(text: widget.email);
    experience = TextEditingController(text: widget.experience);
    email = TextEditingController(text: widget.email);
    price1=TextEditingController(text: widget.price);
    price2=TextEditingController(text: widget.multiplesession);

    if (widget.gender == "Male") {
      radioValue == "Male";
    } else {
      radioValue == "Female";
    }
    gettype();
    super.initState();
  }
gettype() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
   setState(() {
     type=prefs.getString("type");
     print(type);
   });
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
  }

  String profileimage="";

  File image;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0XFF001736),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0XFF001736),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1.05,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4.5),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: SizeConfig.blockSizeVertical * 7.5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: SizeConfig.blockSizeVertical * 7.45,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: image != null
                                    ? FileImage(File(image.path))
                                    : widget.photo == null
                                        ? NetworkImage(
                                            "https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png")
                                        : NetworkImage(widget.photo),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 55,
                        top: SizeConfig.blockSizeVertical * 10),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => ActionSheet()
                                    .actionSheet(context, onCamera: () {
                                  FocusScope.of(context).unfocus();
                                  chooseCameraFile().then((File file) {
                                    if (file != null) {
                                      Dialogs.showLoadingDialog(
                                          context, loginLoader);
                                      uploadImage
                                          .uploadImage(context, image: image,type:type)
                                          .then((value) {
                                        print(value);
                                        if (value != null) {
                                          if (value.meta.status == "200") {
                                            setState(() {
                                              profileimage =
                                                  value.file.toString();
                                              print("jnsdamkod" +
                                                  value.file.toString());
                                            });
                                            Navigator.of(
                                                    loginLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                          } else {
                                            Navigator.of(
                                                    loginLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                            showAlertDialog(
                                              context,
                                              value.meta.message,
                                              "",
                                            );
                                          }
                                        } else {
                                          Navigator.of(
                                                  loginLoader.currentContext,
                                                  rootNavigator: true)
                                              .pop();
                                          showAlertDialog(
                                            context,
                                            value.meta.message,
                                            "",
                                          );
                                        }
                                      }).catchError((error) {
                                        Navigator.of(loginLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();
                                        showAlertDialog(
                                          context,
                                          error.toString(),
                                          "",
                                        );
                                      });
                                    }
                                  }).catchError((onError) {});
                                }, onGallery: () {
                                  FocusScope.of(context).unfocus();
                                  androidchooseImageFile().then((value) {
                                    if (value != null) {
                                      Dialogs.showLoadingDialog(
                                          context, loginLoader);
                                      uploadImage
                                          .uploadImage(context, image: image,type:type)
                                          .then((value) {
                                        if (value != null) {
                                          if (value.meta.status == "200") {
                                            setState(() {
                                              profileimage =
                                                  value.file.toString();
                                              print("jnsdamkod" +
                                                  value.file.toString());
                                            });
                                            Navigator.of(
                                                    loginLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                          } else {
                                            Navigator.of(
                                                    loginLoader.currentContext,
                                                    rootNavigator: true)
                                                .pop();
                                            showAlertDialog(
                                              context,
                                              value.meta.message,
                                              "",
                                            );
                                          }
                                        } else {
                                          Navigator.of(
                                                  loginLoader.currentContext,
                                                  rootNavigator: true)
                                              .pop();
                                          showAlertDialog(
                                            context,
                                            value.meta.message,
                                            "",
                                          );
                                        }
                                      }).catchError((error) {
                                        Navigator.of(loginLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();
                                        showAlertDialog(
                                          context,
                                          error.toString(),
                                          "",
                                        );
                                      });
                                    }
                                    setState(() {
                                      //  loading = true;
                                    });
                                  }).catchError((onError) {

                                    showAlertDialog(context, onError.toString(), "");
                                  });
                                }, text: "Select profile image"));
                      },
                      child: Container(
                        width: SizeConfig.blockSizeVertical * 4.5,
                        height: SizeConfig.blockSizeVertical * 4.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          child: Icon(
                            Icons.add_circle,
                            color: Color(backgroundColorBlue),
                            size: SizeConfig.blockSizeVertical * 5,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
                right: SizeConfig.screenWidth * 0.05,
                left: SizeConfig.screenWidth * 0.05,
              ),
              alignment: Alignment.center,
              child: Form(
                key: nameForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About"),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      maxLines: 3,
                      maxLength: 500,
                      controller: firstNameController,
                      focusNode: firstNameFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,

                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Color(fontColorGray))),
                        hintText: "About",
                        isDense: true,
                        contentPadding:
                            EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
                      ),
                      onFieldSubmitted: (term) {
                        firstNameFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(lastNameFocusNode);
                        filledFn = true;
                      },
                      onChanged: (v) {
                        setState(() {
                          filledFn = true;
                        });
                      },
                      validator: (c) {
                        if (c.isEmpty) return "Please fill required fields";
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Text("Price (in INR) for Single Session"),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: price1,
                        // focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          hintText: "Price",
                          isDense: true,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeVertical * 1.5),
                        ),

                        onChanged: (v) {
                          setState(() {
                            filledFn = true;
                          });
                        },

                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Price (in INR) for Multiple Session"),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(

                        controller: price2,
                        // focusNode: firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          hintText: "Price",
                          isDense: true,
                          contentPadding: EdgeInsets.all(
                              SizeConfig.blockSizeVertical * 1.5),
                        ),
                        onFieldSubmitted: (term) {
                          //// firstNameFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(lastNameFocusNode);
                          filledFn = true;
                        },
                        onChanged: (v) {
                          setState(() {
                            filledFn = true;
                          });
                        },
                        validator: (c) {
                          if (c.isEmpty) return "Please fill required fields";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.1, vertical: 10),
              child: MaterialButton(

                onPressed: () {
                  print(email.text);
                 if(int.parse(price1.text)<500||int.parse(price1.text)>2500){
                   Fluttertoast.showToast(msg: "Select Single Session value between INR 500 to INR 2,500");
                 }
                 else if(int.parse(price2.text)<300||int.parse(price2.text)>2500){
                   Fluttertoast.showToast(msg: "Select Multiple Session value between INR 300 to INR 2,500");
                 }
                 else{
                   Dialogs.showLoadingDialog(context, loginLoader);
                   /* Future.delayed(Duration(seconds: 2)).then((value) {
                    SharedPreferencesTest().checkIsLogin("0");
                    Navigator.of(context).pushNamed('/Price5');
                  });*/
                   // print(mobileController.text);
                   createUser
                       .createCounsellor(
                       aadhar: "",
                       about: firstNameController.text,
                       certificate: "",
                       device_id: "",
                       education: "",
                       email: "",
                       experience: "",
                       first_name: "",
                       gender: "",
                       language_ids: "",
                       last_name: lastNameController.text,
                       linkedin: "",
                       phone: "",
                       photo: profileimage,
                       price: price1.text,
                       price_3: (int.parse(price2.text)*3).toString(),
                       price_5: (int.parse(price2.text)*5).toString(),
                       multiple_sessions:(int.parse(price2.text)).toString(),
                       resume: "",
                       topic_ids: "")
                       .then((value) async {
                     if (value != null) {
                       print("jkbsdvbjk" + value.meta.status.toString());
                       if (value.meta.status == "200") {

                         Fluttertoast.showToast(msg: "Profile Updated");
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => HomeMain()));

                         // toastLong(value.meta.message);
                         // toastLong("Profile Update")
                         //toast(value.meta.message);
                         // SharedPreferencesTest().checkIsLogin("0");
                         // SharedPreferencesTest().saveTherapistId(value.therapistId);
                         // SharedPreferences prefs= await SharedPreferences.getInstance();
                         // prefs.setString("therapistid", value.therapistId);
                         // prefs.setString("firstname", firstNameController.text);
                         // prefs.setString("lastname", lastNameController.text);
                             ;
                       } else {
                         Fluttertoast.showToast(msg: "Profile Update");
                         Navigator.of(loginLoader.currentContext,
                             rootNavigator: true)
                             .pop();
                         showAlertDialog(
                           context,
                           value.meta.message,
                           "",
                         );
                       }
                     } else {
                       Navigator.of(loginLoader.currentContext,
                           rootNavigator: true)
                           .pop();
                       showAlertDialog(
                         context,
                         value.meta.message,
                         "",
                       );
                     }
                   }).catchError((error) {
                     Navigator.of(loginLoader.currentContext,
                         rootNavigator: true)
                         .pop();
                     showAlertDialog(
                       context,
                       error.toString(),
                       "",
                     );
                   });
                 }
                },
                color: Color(backgroundColorBlue),
                minWidth: SizeConfig.screenWidth,
                height: 48,
                child: Text(
                  "DONE",
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<File> chooseCameraFile() async {
    await ImagePicker.platform
        .pickImagePath(
      source: ImageSource.camera,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value);
      });
      if (image.path != null) {}
    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }

  Future<File> androidchooseImageFile() async {
    await ImagePicker.platform
        .pickImagePath(
      source: ImageSource.gallery,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value);
      });
      if (image.path != null) {}
    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }
}
