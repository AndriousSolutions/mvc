///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  21 Jun 2018
///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  16 Jun 2018
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mvc/MVC.dart' show MVCState;
import 'package:prefs/prefs.dart';

import 'View.dart';



class App extends StatefulWidget {

  factory App({Key key}){
    if(_this == null) _this = App._getInstance(key: key);
    return _this;
  }
  /// Make only one instance of this class.
  static App _this;

  App._getInstance({Key key}) : _vw = View(), super(key: key);
  final View _vw;

  @override
  State createState(){
    /// Pass this 'view' to the State object.
    return MVCState(view: _vw);
  }

  Future<bool> init() async{
    /// The default is to dump the error to the console.
    /// Instead, a custom function is called.
    FlutterError.onError = (FlutterErrorDetails details) async {
      await _reportError(details);
    };
    return _vw.init();
  }




  static getThemeData() {

    Prefs.getStringF('theme').then((value){

      var theme = value ?? 'light';

      ThemeData themeData;

      switch (theme) {
        case 'light':
          themeData = ThemeData.light();
          break;
        case 'dark':
          themeData = ThemeData.dark();
          break;
        default:
          themeData = ThemeData.fallback();
      }
      return themeData;
    });
  }



  static setThemeData(String theme) {
    switch (theme) {
      case 'light':
        break;
      case 'dark':
        break;
      default:
        theme = 'fallback';
    }
    Prefs.setString('theme', theme);
  }
}

/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack
  FlutterError.dumpErrorToConsole(details);
}