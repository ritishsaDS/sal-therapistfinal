import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Utils/Colors.dart';
import 'package:mental_health/Utils/SizeConfig.dart';

Container popularArticles() {
  return Container(
    width: SizeConfig.screenWidth,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 1.5,
        horizontal: SizeConfig.screenWidth * 0.05),
    child: Text(
      "POPULAR ARTICLES",
      style: GoogleFonts.openSans(
        color: Color(fontColorGray),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Container popularAudioText() {
  return Container(
    width: SizeConfig.screenWidth,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 1.5,
        horizontal: SizeConfig.screenWidth * 0.05),
    child: Text(
      "POPULAR AUDIOS",
      style: GoogleFonts.openSans(
        color: Color(fontColorGray),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Container popularVideoText() {
  return Container(
    width: SizeConfig.screenWidth,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 1.5,
        horizontal: SizeConfig.screenWidth * 0.05),
    child: Text(
      "POPULAR VIDEOS",
      style: GoogleFonts.openSans(
        color: Color(fontColorGray),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
