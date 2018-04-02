import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext, Widget, VoidCallback;
import 'package:mvc/AppController.dart' show AppController;
///
///
///
///    View Class for a MVC design pattern.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-03-25
///
abstract class AppView{

  AppView(this.con){
    // Give the Controller access to the View's build() function.
    con.setView(this);
  }

  // Subclass of this View has access to the Controller,
  // but of little use. Access to the subclass is better.
  final AppController con;

  // Like a State object, the view has access to these properties.
  // There's really no need to reference the 'widget' as the
  // Controller now takes on it role.
  get widget => con.widget;

  // BuildContext is always useful.
  get context => con.context;

  // Ensure the State Object is 'mounted' and not being terminated.
  get mounted => con.mounted;

  // Every subclass must implement this method.
  // As a View should.
  Widget build(BuildContext context);

  // Allows the View to call setState() if you must.
  // Although encapsulation would have all function executed
  // instead inside the Controller.
  setState(VoidCallback fn) {
    con.reState(fn);
  }
}


