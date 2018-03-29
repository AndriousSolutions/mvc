import 'package:flutter/material.dart';

///
///
///
/// StatefulWidget Class encapsulating both State and Widget objects.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-03-25
///
abstract class StateWidget extends StatefulWidget{
  StateWidget([Key key]): super(key: key){

     _state = new _WidgetState(this);
  }

  _WidgetState _state;

  get widget => _state.widget; // this.createElement().state.widget;

  get context => _state.context; // this.createElement().state.context;

  get mounted => _state.mounted; // this.createElement().state.mounted;

  Widget build(BuildContext context);

  setState(VoidCallback fn) {
    _state.reState(fn);
  }

  @override
  createState() => _state;
}


class _WidgetState extends State<StateWidget> with WidgetsBindingObserver {

  _WidgetState(this.stateWidget);

  final StateWidget stateWidget;

  @override
  Widget build(BuildContext context) {
    return stateWidget.build(context);
  }

  reState(VoidCallback fn) {
    setState(fn);
  }

  refresh() {
    // Refresh the Widget Tree Interface
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    setState(() {
//      _lastLifecyleState = state;
//    });
  }
}


