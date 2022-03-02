import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mental_health/UI/Info%203.dart';
import 'package:mental_health/UI/LoginScreen.dart';
import 'package:mental_health/Utils/AlertDialog.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/CommonWidgets.dart';
import 'package:mental_health/Utils/Dialogs.dart';
import 'package:mental_health/Utils/SizeConfig.dart';
import 'package:mental_health/constant/AppColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Info1.dart';
import 'Info2.dart';
import 'Price2.dart';
import 'Price3.dart';
import 'ProfessionalInfo1.dart';
import 'ProfessionalInfo2.dart';

bool isKyc = false;

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key key}) : super(key: key);

  @override
  _KYCScreenState createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController panCardNumber = TextEditingController();
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchAddress = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  FocusNode panCardFn;
  FocusNode beneficiaryNameFn;
  FocusNode bankNameFn;
  FocusNode branchAddressFn;
  FocusNode accountNumberFn;
  FocusNode ifscCodeFn;
  int _currVal = 1;
  String _currText = 'Savings';
  String radioGroupValue = "";
  bool  isLoading = false;
  bool  isError = false;

  List<GroupModel> _group = [
    GroupModel(
      text: "Savings",
      index: 1,
    ),
    GroupModel(
      text: "Current",
      index: 2,
    ),
  ];

  @override
  void initState() {
    super.initState();

    panCardFn = FocusNode();
    beneficiaryNameFn = FocusNode();
    bankNameFn = FocusNode();
    branchAddressFn = FocusNode();
    accountNumberFn = FocusNode();
    ifscCodeFn = FocusNode();
  }

  @override
  void dispose() {
    panCardFn.dispose();
    beneficiaryNameFn.dispose();
    bankNameFn.dispose();
    branchAddressFn.dispose();
    accountNumberFn.dispose();
    ifscCodeFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> widgetList = new List<Widget>();
    var child =
     Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical,
                        horizontal: SizeConfig.screenWidth * 0.05),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pancard Number",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05),
                    child: TextFormField(
                      controller: panCardNumber,
                      focusNode: panCardFn,
                      textInputAction: TextInputAction.next,
                      // inputFormatters: [
                      //   new LengthLimitingTextInputFormatter(12),
                      // ],
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z 0-9]")),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter Number",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        panCardFn.unfocus();
                        FocusScope.of(context).requestFocus(beneficiaryNameFn);
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                      vertical: SizeConfig.blockSizeVertical,
                    ),
                    child: Text(
                      "Bank Details",
                      style: GoogleFonts.openSans(
                          color: Color(backgroundColorBlue),
                          fontSize: SizeConfig.blockSizeVertical * 2.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Beneficiary Name",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: TextFormField(
                      controller: beneficiaryName,
                      maxLength: 50,
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                      ],
                      focusNode: beneficiaryNameFn,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter Name",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      onFieldSubmitted: (value) {
                        beneficiaryNameFn.unfocus();
                        FocusScope.of(context).requestFocus(bankNameFn);
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bank Name",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                      ],
                      maxLength: 50,
                      controller: bankName,
                      focusNode: bankNameFn,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter Name",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        bankNameFn.unfocus();
                        FocusScope.of(context).requestFocus(branchAddressFn);
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Branch Address",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                      ],
                      maxLength: 50,
                      controller: branchAddress,
                      focusNode: branchAddressFn,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter Address",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        branchAddressFn.unfocus();
                        FocusScope.of(context).requestFocus(accountNumberFn);
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account Type",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: _group
                        .map((t) => Expanded(
                              child: RadioListTile(
                                title: Text("${t.text}"),
                                groupValue: _currVal,
                                value: t.index,
                                onChanged: (val) {
                                  setState(() {
                                    _currVal = val;
                                    _currText = t.text;
                                  });
                                },
                              ),
                            ))
                        .toList(),
                  ),
                  /*              Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width:SizeConfig.screenWidth * 0.4,
                  child: RadioListTile<String>(
                    value: radioGroupValue,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      groupValue: radioGroupValue,
                      title: Text("Savings"),
                      onChanged: (String value){
                    setState(() {
                      radioGroupValue = value;
                    });
                      }),
            ),

              */ /*  Container(
                  width:SizeConfig.screenWidth * 0.4,
                  child: RadioListTile<String>(value: radioGroupValue,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      groupValue: radioGroupValue,
                      title: Text("Current"),
                      onChanged: (String value){
                        setState(() {
                          radioGroupValue = value;
                        });
                      }),
                )*/ /*
              ],
            ),
          )*/

                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account Number",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: TextFormField(
                      controller: accountNumber,
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      ],
                      maxLength: 50,
                      focusNode: accountNumberFn,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter Account Number",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        accountNumberFn.unfocus();
                        FocusScope.of(context).requestFocus(ifscCodeFn);
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "IFSC Code",
                      style: GoogleFonts.openSans(
                          color: Color(fontColorGray),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        new WhitelistingTextInputFormatter(
                            RegExp("[a-zA-Z0-9]")),
                      ],
                      maxLength: 50,
                      controller: ifscCode,
                      focusNode: ifscCodeFn,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray))),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.05,
                              vertical: SizeConfig.blockSizeVertical),
                          hintText: "Enter IFSC Code",
                          hintStyle: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontWeight: FontWeight.w400,
                          )),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {
                        ifscCodeFn.unfocus();
                      },
                      validator: (s) {
                        if (s.isEmpty) return "This field is required";
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05,
                        vertical: SizeConfig.blockSizeVertical * 2),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          print("jkhnnsdrnkl");
                          uploadkyc();
                          if (_currText != null && _currText != "") {
                            setState(() {
                              isKyc = true;
                            });


                          } else {
                            print("jkhnnsdddddddrnkl");
                            Fluttertoast.showToast(
                                msg: "Please select account type");
                          }
                        }
                      },
                      child: Text(
                        "SUBMIT",
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      color: Color(backgroundColorBlue),
                      minWidth: SizeConfig.screenWidth,
                      height: SizeConfig.blockSizeVertical * 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
              key: formKey,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
        title: Text(
          "KYC",
          style: GoogleFonts.openSans(
            color: Color(midnightBlue),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    widgetList.add(child);
    if (isLoading) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(colorPrimary),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }
  Future<void> uploadkyc() async {

    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body={
      "aadhar": "",
      "about":"",
      "bank_account_no": accountNumber.text,
      "bank_account_type": _currText,
      "bank_name": bankName.text,
      "branch_name": branchAddress.text,
      "certificate": "",
      "device_id": "",
      "education":"" ,
      "experience":"",
      "first_name": prefs.getString("firstname"),
      "gender":  "",
      "ifsc": ifscCode.text,
      "phone":"",
      "language_ids":"",
      "last_name": prefs.getString("lastname"),
      "linkedin": "",
      "pan": panCardNumber.text,
      "payee_name": beneficiaryName.text,
      "payout_percentage": "",
      "photo": "",
      "price": "",
      "price_3": "",
      "price_5": "",
      "resume": "",
      "timezone": "GMT+5:30",
      "topic_ids": ""
    };

print(prefs.getString("type"));
print(body);
   var url='';
    if(prefs.getString("type")=="Therapist"){
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/therapist?therapist_id=${prefs.getString('therapistid')}";
    }
    else if(prefs.getString("type")=="Listener"){
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/listener?listener_id=${prefs.getString('therapistid')}";
    }
    else{
      url="https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/counsellor?counsellor_id=${prefs.getString('therapistid')}";
    }
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "accept": "application/json"

    };

    try {
      final response = await put(Uri.parse(url),headers: requestHeaders,



      body:json.encode(body));
      print("bjkb" + response.request.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        SharedPreferences preferences =await SharedPreferences.getInstance();
        preferences.setString("BankAccount", accountNumber.text);
        Navigator.of(context).pushNamed('/HomeMain');
        preferences.setBool("ISKyc", true);
print(responseJson);
        // counsellorid=upcominglist['appointment_slots'][0]['counsellor_id'];
        //  print( upcominglist['appointment_slots'][0]['counsellor_id'],);
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
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
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }

  String validateMobile(String value) {
    String pattern = r'[A-Z]{5}[0-9]{4}[A-Z]{1}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}

class GroupModel {
  String text;
  int index;

  GroupModel({this.text, this.index});
}
