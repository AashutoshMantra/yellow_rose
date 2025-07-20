// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';

class SizeConfig {
   static late  double _screenWidth;
  static late double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static  double textMultiplier=1;
  static  double imageSizeMultiplier=1;
  static  double heightMultiplier=1;
  static  double widthMultiplier=1;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
    print(_blockSizeHorizontal);
    print(_blockSizeVertical);
  }
}

extension dimension on int {
  double get h => ((toDouble()) / 8.52) * SizeConfig.heightMultiplier;
  double get w => ((toDouble()) / 3.93) * SizeConfig.widthMultiplier;
}

extension dimensions on double {
  double get h => (this / 8.52) * SizeConfig.heightMultiplier;
  double get w => (this / 3.93) * SizeConfig.widthMultiplier;
}