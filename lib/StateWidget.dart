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
  StateWidget({Key key}): super(key: key);

  final _WidgetState  _state = new _WidgetState();

  get widget => _state.widget;

  get context => _state.context;

  get mounted => _state.mounted;

  Widget build(BuildContext context);

  setState(VoidCallback fn) {
    _state.reState(fn);
  }


  void initState() {
    // Free to override in subclasses
  }

  void dispose() {
    // Free to override in subclasses
  }

  @override
  createState() => _state.setStateWidget(this);
}


class _WidgetState extends State<StateWidget> with WidgetsBindingObserver {

  StateWidget _stateWidget;

  setStateWidget(StateWidget widget){

    _stateWidget = widget;
  }

  @override
  Widget build(BuildContext context) {
    return _stateWidget.build(context);
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
    _stateWidget.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stateWidget.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    setState(() {
//      _lastLifecyleState = state;
//    });
  }
}


