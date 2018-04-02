import 'package:flutter/foundation.dart';
import 'package:mvc/AppController.dart' show AppController;
///
///
///
///    Model Class for a MVC design pattern.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-03-25
///
class AppModel{


  setAppCon(AppController con) => _con = con;

  AppController _con;
}