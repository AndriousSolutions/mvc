import 'package:flutter/material.dart' show BuildContext, Colors, MaterialApp, StatelessWidget, ThemeData, Widget;
import 'package:flutter/widgets.dart';
import 'package:mvc/AppController.dart' show AppStatefulWidget;
import 'package:mvc/AppView.dart';

///
///
/// 
///    Entrypoint Class for a MVC design pattern.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-03-25
///
class App extends StatelessWidget {

  const App(this.view);

  final AppView view;

  // if you want to start with the StatefulWidget right away.
  static void run(AppView view){
    assert(view != null, 'Must instaniate this class, App, with an Appview parameter object!');
    runApp(new MaterialApp(home:new AppStatefulWidget(view)));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new AppStatefulWidget(view),
    );
  }
}