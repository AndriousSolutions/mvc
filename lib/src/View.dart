import 'package:flutter/material.dart';
import 'Controller.dart' show Controller;
import 'package:mvc/AppView.dart' show AppView;

/// View Class
///
class View extends AppView {

  Controller _con;

  View(con): super(con){

    _con = con;
  }

}

