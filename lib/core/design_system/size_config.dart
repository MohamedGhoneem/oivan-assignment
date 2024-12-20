import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 20.0;
  static double blockSizeVertical = 20.0;
  static double _safeAreaHorizontal = 20.0;
  static double _safeAreaVertical = 20.0;
  static double safeBlockHorizontal = 20.0;
  static double safeBlockVertical = 20.0;

  ///=========================================================
  static double paddingDouble = 24.0;
  static double padding = 16.0;
  static double paddingThreeQuarter = 12.0;
  static double paddingHalf = 8.0;
  static double paddingQuarter = 4.0;
  static double appbarHeight = 44;
  static double appbarIconSize = 32.0;
  static double h1FontSize = 36.0;
  static double h2FontSize = 32.0;
  static double h3FontSize = 24.0;
  static double btnTitleFontSize = 24.0;
  static double titleFontSize = 18.0;
  static double subTitleFontSize = 16.0;
  static double textFontSize = 14.0;
  static double numberFontSize = 16.0;
  static double iconSize = 24.0;
  static double bottomNavbarHeight = 64.0;
  static double bottomNavbarTextSize = 14.0;
  static double cardHeight = 254.0;
  static double cardImageHeight = 168.0;
  static double cardButtonHeight = 36.0;
  static double vision2030BarHeight = 45.0;
  static double logoSize = 146.0;
  static double buttonHeight = 56.0;
  static double splashDividerWidth = 66.65;
  static double btnRadius = 8;
  static double toastIconSize = 8;
  static double borderWidth = 1.0;
  static double itemHeight = 70.0;
  static double textTitleontSize = 36.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    titleFontSize = SizeConfig.safeBlockHorizontal * 4.5;
    textFontSize = SizeConfig.safeBlockHorizontal * 3.25;

    paddingDouble = SizeConfig.safeBlockHorizontal * 6;
    padding = SizeConfig.safeBlockHorizontal * 3;
    paddingThreeQuarter = SizeConfig.safeBlockHorizontal * 2.25;
    paddingHalf = SizeConfig.safeBlockHorizontal * 1.5;
    paddingQuarter = SizeConfig.safeBlockHorizontal * .75;
    appbarHeight = SizeConfig.safeBlockHorizontal * 13;
    appbarIconSize = SizeConfig.safeBlockHorizontal * 6.85;
    h1FontSize = SizeConfig.safeBlockHorizontal * 8;
    h2FontSize = SizeConfig.safeBlockHorizontal * 6.75;
    h3FontSize = SizeConfig.safeBlockHorizontal * 5.5;
    btnTitleFontSize = SizeConfig.safeBlockHorizontal * 5;
    titleFontSize = SizeConfig.safeBlockHorizontal * 4;
    subTitleFontSize = SizeConfig.safeBlockHorizontal * 3.75;
    textFontSize = SizeConfig.safeBlockHorizontal * 3.25;
    numberFontSize = SizeConfig.safeBlockHorizontal * 3.75;
    iconSize = SizeConfig.safeBlockHorizontal * 6;
    bottomNavbarHeight = SizeConfig.safeBlockHorizontal * 14;
    cardHeight = SizeConfig.safeBlockVertical * 28;
    cardImageHeight = SizeConfig.safeBlockVertical * 21;
    cardButtonHeight = 36.0;
    vision2030BarHeight = SizeConfig.safeBlockHorizontal * 10;
    logoSize = SizeConfig.safeBlockVertical * 20;
    buttonHeight = SizeConfig.safeBlockHorizontal * 12;
    splashDividerWidth = SizeConfig.safeBlockHorizontal * 18;
    btnRadius = SizeConfig.safeBlockHorizontal * 1.5;
    toastIconSize = SizeConfig.safeBlockHorizontal * 10;

    textTitleontSize = 36;
  }
}
