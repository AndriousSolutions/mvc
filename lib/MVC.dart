///
///
///
///    Classes for generic Flutter MVC approach.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-04-19
///

import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart' show Key, VoidCallback;

import 'StatedWidget.dart';

/// The Controller
class MVController {
  MVController([this._dataObj]);

  StatedData _dataObj;

  /// A reference to the State object.
  _MVCState state;

  /// Allow for the widget getter in the build() function.
  get widget => state?.view;

  /// BuildContext is always useful in the build() function.
  get context => state?.context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => state?.mounted;

  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree.
  /// (i.e. Subscribe to another object it depends on during [initState],
  /// unsubscribe object and subscribe to a new object when it changes in
  /// [didUpdateWidget], and then unsubscribe from the object in [dispose].
  void initState() {
    _dataObj?.initState();
  }

  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. It might reinsert it into another part of the tree.
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  void deactivate(){
    _dataObj?.deactivate();
  }

  /// The framework calls this method when this [State] object will never
  /// build again. The [State] object's lifecycle is terminated.
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  void dispose(){
    _dataObj?.dispose();
  }

  void didUpdateWidget(MCView oldWidget) {
    _dataObj?.didUpdateWidget(oldWidget);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _dataObj?.didChangeAppLifecycleState(state);
  }

  void setState(VoidCallback fn){
    /// Call the State object's setState() function.
    state?.reState(fn);
  }

  void refresh(){
    /// Refresh the Widget Tree Interface
    state?.reState(() {});
  }
}


abstract class MCView extends StatefulWidget{
  const MCView({
    this.con,
    Key key,
  }) : super(key: key);

  final MVController con;

  /// A getter with a more descriptive name.
  get controller => con;

  @override
  createState(){

    /// Pass this 'view' to a State object.
    var state = new _MVCState(this, con);

    /// Get a reference of the State object for the Controller.
    con?.state = state;

    return state;
  }

  /// Allow for the widget getter in the build() function.
  get widget => this;

  /// BuildContext is always useful in the build() function.
  get context => con.state.context ?? createState().context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => con.state.mounted ?? createState().mounted;

  /// Provide the setState() function to the build() function.
  /// Although it's the Controller that should do all the calling of setState() function.
  setState(VoidCallback fn){
    con?.setState(fn);
  }

  /// Provide 'the view'
  Widget build(BuildContext context);
}



/// The State Object
class _MVCState extends State<MCView> with WidgetsBindingObserver  {
   _MVCState(
      this.view,
      this._con,
      );

  final MCView view;

  final MVController _con;

  get buildWidget => _build;
  Widget _build;

  @override
  void initState(){
    /// called when the [State] object is first created.
    super.initState();
    _con?.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void deactivate(){
    /// called when this [State] object is removed from the tree.
    _con?.deactivate();
    super.deactivate();
  }

  @override
  void dispose(){
    /// called when this [State] object will never build again.
    _build = null;
    WidgetsBinding.instance.removeObserver(this);
    _con?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MCView oldWidget) {
    /// Override this method to respond when the [widget] changes (e.g., to start
    /// implicit animations).
    /// The framework always calls [build] after calling [didUpdateWidget], which
    /// means any calls to [setState] in [didUpdateWidget] are redundant.
    super.didUpdateWidget(oldWidget);
    _con?.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing either the values AppLifecycleState.paused or AppLifecycleState.resumed.
    _con?.didChangeAppLifecycleState(state);
  }

  void reState(VoidCallback fn) {
    /// Calls the 'real' setState()
    /// setState() can only be called within this class.
    setState(fn);
  }

  /// The View
  Widget build(BuildContext context){
    /// Here's where the magic happens.
    _build = view.build(context);
    return _build;
  }
}


/*  Copy n' paste this code to then implement these Classes:

import 'package:flutter/material.dart';

import 'package:mvc/MVC.dart';

import 'Controller.dart';

class View extends MCView{
    View(this._con): super(con: _con);

    final Controller _con;

}


import 'MVC.dart';

class Controller extends MVController {
    Controller(this._model);

    final Model _model;
}

 */