import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cashfuse/utils/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  ThemeController() {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  Color _pickColor = Color(0xff009688); //Color(0xFF2D3D95);
  Color get pickColor => _pickColor;

  Color _pickSecondaryColor = Color(0xff000000); //Color(0xFFF07532);
  Color get pickSecondaryColor => _pickSecondaryColor;

  void _loadCurrentTheme() async {
    global.sp = await SharedPreferences.getInstance();
    if (global.sp.getInt('primaryColor') != null) {
      int colorVal = global.sp.getInt('primaryColor');
      _pickColor = Color(colorVal);
      int secColorVal = global.sp.getInt('secondaryColor');
      _pickSecondaryColor = Color(secColorVal);
    } else {
      _pickColor = Color(0xff009688);
      _pickSecondaryColor = Color(0xff000000);
    }

    update();
  }

  void setPickColor(Color color) async {
    _pickColor = color;
    global.sp.setInt('primaryColor', _pickColor.value);

    update();
  }

  void setSecondaryPickColor(Color color) async {
    _pickSecondaryColor = color;
    global.sp.setInt('secondaryColor', _pickSecondaryColor.value);

    update();
  }
}
