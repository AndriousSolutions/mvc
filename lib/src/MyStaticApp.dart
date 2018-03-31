import 'package:flutter/widgets.dart';
import 'package:mvc/AppController.dart' show AppStatefulWidget;
import 'View.dart' show View;
import 'Controller.dart' show Controller;
import 'Model.dart' show Model;

/// App Class
///
class MyApp{

  MyApp(){

    mod = new Model();

    con = new Controller(mod);

    vw = new View(con);
  }

  static View vw;
  static Controller con;
  static Model mod;

  StatefulWidget statefulWidget(){

    return new AppStatefulWidget(vw);
  }
}