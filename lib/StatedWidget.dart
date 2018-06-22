///
///
///
///    Classes for generic Flutter MVC approach.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-04-19
///

import 'package:flutter/widgets.dart' show AppLifecycleState, BuildContext, StatefulWidget, VoidCallback, Widget;

import 'MVC.dart' show MCView, MVController;

abstract class StatedWidget extends MCView{
  StatedWidget({this.data}) : super(data._con);

  final StatedData data;

  /// Where the magic happens.
  Widget build(BuildContext context);


  void onPressed(){

      try {

        data?.onPressed();

      } catch (ex){

      }
  }

  void onTap(){

      try {

        data?.onTap();

      } catch (ex){

      }
  }
}



class StatedData{
  StatedData() {
    /// Favor Composition over Inheritance.
    _con = new MVController(this);
  }
  var _con;
  get con => _con;
  /// A getter with a more descriptive name.
  get controller => _con;

  get widget => _con.widget;

  get context => _con.context;

  get mounted => _con.mounted;

  void initState() {
    /// called only when the [State] object is first created.
  }

  void deactivate() {
    /// called when this [State] object is removed from the tree.
  }

  void dispose() {
    /// called when this [State] object will never build again.
  }

  void didUpdateWidget(StatefulWidget oldWidget) {
    /// Override this method to respond when the [widget] changes.
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// called when the app's lifecycle state changes.
  }

  void onPressed(){
    /// Override to answer a call to widget.onPressed.
  }

  void onTap(){
    /// Override to answer a call to widget.onTap.
  }

  setState(VoidCallback fn){
    _con.setState(fn);
  }

  refresh() {
    _con.refresh();
  }
}
