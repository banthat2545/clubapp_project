import 'package:clubapp_project/pages/options_screen.dart';
import 'package:clubapp_project/pages/first_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRote {
  static const String loginScreen = '/loginScreen';
  static const String firstScreen = '/firstScreen';
  static const String OptionsScreen = '/OptionsScreen';
  static get all => <String, WidgetBuilder>{
        firstScreen: (context) => const first_screen(),
        OptionsScreen: (context) =>  Options_Screen(),
      };

}
