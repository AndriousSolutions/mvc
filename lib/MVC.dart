///
///
///
///    Classes for generic Flutter MVC approach.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-04-19
///

library mvc;

import 'package:flutter/widgets.dart' show AppLifecycleState, BuildContext, Key, RenderObject, State, StatefulWidget, VoidCallback, Widget, WidgetsBinding, WidgetsBindingObserver;

import 'package:flutter/material.dart' show AppLifecycleState, BuildContext, Key, RenderObject, State, StatefulWidget, VoidCallback, Widget, WidgetsBinding, WidgetsBindingObserver, mustCallSuper;

import 'StatedWidget.dart';




/// The State Object for this MVC Design Pattern
class MVCState extends State<StatefulWidget> with WidgetsBindingObserver  {

  /// Allow for Mixins
  MVCState(): super();


  MVCState.set(MCView vw){
    setView(vw);
  }


  MVCState setView(MCView vw){
    _view = vw;
    _con = _view?._con;
    /// Get a reference of the State object for the Controller.
    _view?._con?._state = this;
    return this;
  }

  get view => _view;
  MCView _view;

  MVController _con;

  get buildWidget => _build;
  Widget _build;


  @override
  void initState(){
    /// called when the [State] object is first created.
    super.initState();
    _view?.widget = widget;
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
  @mustCallSuper
  void dispose(){
    /// called when this [State] object will never build again.
    _build = null;
    WidgetsBinding.instance.removeObserver(this);
    _con?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
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

  void reState(fn) {
    /// Calls the 'real' setState()
    /// setState() can only be called within this class.
    /// You'd get an error if not mounted.
    if(mounted){
      setState(fn);
    }
  }

  /// The View
  Widget build(BuildContext context){
    /// Here's where the magic happens.
    _build = _view.build(context);
    return _build;
  }
}



/// The View of MVC
abstract class MCView{

  MCView([this._con]);

  MVController _con;

  get con => controller;
  set con(MVController c) => controller = c;
  /// A getter with a more descriptive name.
  get controller => _con;
  set controller(MVController c){
    assert(_con == null, "A Controller already assigned!");
    _con = c;
  }

  /// Allow for the widget getter in the build() function.
  StatefulWidget _widget;
  get widget => _widget ?? this;
  set widget(StatefulWidget w) => _widget = w;

  /// BuildContext is always useful in the build() function.
  get context => _con?._state?.context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => _con?._state?.mounted;

  /// Provide the setState() function to the build() function.
  /// Although it's the Controller that should do all the calling of setState() function.
  setState(fn){
    _con?.setState(fn);
  }

  /// Provide 'the view'
  Widget build(BuildContext context);
}




/// The Controller of MVC
class MVController {
  MVController([this._dataObj]);

  StatedData _dataObj;

  /// A reference to the State object.
  get state => _state;
  MVCState _state;

  /// Allow for the widget getter in the build() function.
  get widget => _state?._view;

  /// BuildContext is always useful in the build() function.
  get context => _state?.context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => _state?.mounted;


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

  void didUpdateWidget(StatefulWidget oldWidget) {
    _dataObj?.didUpdateWidget(oldWidget);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _dataObj?.didChangeAppLifecycleState(state);
  }

  void setState(fn){
    /// Call the State object's setState() function.
    _state?.reState(fn);
  }

  void refresh(){
    /// Refresh the Widget Tree Interface
    _state?.reState(() {});
  }
}







/*  Copy n' paste this code to then implement these Classes:

import 'package:mvc/MVC.dart';

import 'Controller.dart';

class View extends MCView{
    View(this._con): super(con: _con);

    final Controller _con;

}

     or If you don't want to use a parameter:

import 'package:mvc/MVC.dart';

import 'Controller.dart';

class View extends MCView{
  View(): _con = Controller() {
    this.con = _con;
  }








import 'MVC.dart';

class Controller extends MVController {
    Controller(this._model);

    final Model _model;
}

 */