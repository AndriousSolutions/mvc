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

import 'package:flutter/material.dart' show AppLifecycleState, BuildContext, GlobalKey, Image, Key, RenderObject, State, StatefulWidget, VoidCallback, Widget, WidgetsBinding, WidgetsBindingObserver, mustCallSuper;

import 'package:flutter/widgets.dart' show AppLifecycleState, BuildContext, Key, RenderObject, State, StatefulWidget, VoidCallback, Widget, WidgetsBinding, WidgetsBindingObserver;

import 'package:flutter/material.dart' show AppLifecycleState, BuildContext, Key, RenderObject, State, StatefulWidget, VoidCallback, Widget, WidgetsBinding, WidgetsBindingObserver, mustCallSuper;

import 'package:flutter/foundation.dart' show BindingBase, DiagnosticPropertiesBuilder, Key, VoidCallback, mustCallSuper;


/// The State Object for this MVC Design Pattern
class MVController extends State<StatefulWidget> with WidgetsBindingObserver{
  
  /// Allow for Mixins
  MVController(): super();

  
  /// The View
  @override
  Widget build(BuildContext context){
    /// Here's where the magic happens.
    _build = _view.build(context);
    return _build;
  }

  
  get view => _view;
  MCView _view;


  get buildWidget => _build;
  Widget _build;

  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree.
  /// (i.e. Subscribe to another object it depends on during [initState],
  /// unsubscribe object and subscribe to a new object when it changes in
  /// [didUpdateWidget], and then unsubscribe from the object in [dispose].
  @override
  void initState(){
    /// called when the [State] object is first created.
    super.initState();
    _view?.widget = widget;
    WidgetsBinding.instance.addObserver(this);
  }

  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. It might reinsert it into another part of the tree.
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  @override
  void deactivate(){
    super.deactivate();
  }

  /// The framework calls this method when this [State] object will never
  /// build again. The [State] object's lifecycle is terminated.
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  @override
  @mustCallSuper
  void dispose(){
    /// called when this [State] object will never build again.
    _build = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    /// Override this method to respond when the [widget] changes (e.g., to start
    /// implicit animations).
    /// The framework always calls [build] after calling [didUpdateWidget], which
    /// means any calls to [setState] in [didUpdateWidget] are redundant.
    super.didUpdateWidget(oldWidget);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing either the values AppLifecycleState.paused or AppLifecycleState.resumed.
  }


  void setState(fn){
    /// Call the State object's setState() function.
    super.setState(fn);
  }

  void refresh(){
    /// Refresh the Widget Tree Interface
    setState(() {});
  }
}



/// The View of MVC
abstract class MCView{

  MCView([this._con]){
    _con?._view = this;
  }

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
  get context => _con?.context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => _con?.mounted;

  /// Provide the setState() function to the build() function.
  /// Although it's the Controller that should do all the calling of setState() function.
  setState(fn){
    _con?.setState(fn);
  }

  /// Provide 'the view'
  Widget build(BuildContext context);
}




abstract class StatedWidget {

  
  StatedWidget(){
    _widget._state._statedWidget = this;
  }

  final WidgetStated _widget = WidgetStated(key: GlobalKey<StatedWidgetState>());

  /// This is where the magic happens.
  Widget build(BuildContext context);
  

  void initState(){

  }

  void deactivate(){

  }

  void dispose(){

  }

  void reassemble() {

  }

  void didUpdateWidget(StatefulWidget oldWidget) {

  }

  void didChangeAppLifecycleState(AppLifecycleState state) {

  }

  void didChangeDependencies() {

  }

  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    _widget._state.debugFillProperties(properties);
  }

  get state => _widget._state;

  get widget => _widget;

  get context => _widget._state.context;

  get mounted => _widget._state.mounted;

  void setState(fn){
    /// Call the State object's setState() function.
    _widget._state._reState(fn);
  }

  void refresh(){
    /// Refresh the Widget Tree Interface
    setState(() {});
  }
}


class WidgetStated extends StatefulWidget {
  WidgetStated({ Key key }) : super(key: key);

  final StatedWidgetState _state = StatedWidgetState();

  @override
  State createState(){
    return _state;
  }
}


class StatedWidgetState extends State<WidgetStated> with WidgetsBindingObserver{

  StatedWidget _statedWidget;

  @override
  Widget build(BuildContext context){
    /// Here's where the magic happens.
    return _statedWidget.build(context);
  }


  /// The framework will call this method exactly once.
  /// Only when the [State] object is first created.
  ///
  /// Override this method to perform initialization that depends on the
  /// location at which this object was inserted into the tree.
  /// (i.e. Subscribe to another object it depends on during [initState],
  /// unsubscribe object and subscribe to a new object when it changes in
  /// [didUpdateWidget], and then unsubscribe from the object in [dispose].
  @override
  void initState(){
    super.initState();
    _statedWidget.initState();
  }


  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. It might reinsert it into another part of the tree.
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  @override
  void deactivate(){
    _statedWidget.deactivate();
    super.deactivate();
  }


  /// The framework calls this method when this [State] object will never
  /// build again. The [State] object's lifecycle is terminated.
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  @override
  void dispose(){
    _statedWidget.dispose();
    /// called when this [State] object will never build again.
    super.dispose();
  }


  /// Notify the framework that the internal state of this object has changed.
  void _reState(fn){
    /// Call the State object's setState() function.
    super.setState(fn);
  }


  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  /// See also:
  ///
  /// * [BindingBase.reassembleApplication].
  /// * [Image], which uses this to reload images.
  @mustCallSuper
  void reassemble() {
    super.reassemble();
    _statedWidget.reassemble();
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    /// Override this method to respond when the [widget] changes (e.g., to start
    /// implicit animations).
    /// The framework always calls [build] after calling [didUpdateWidget], which
    /// means any calls to [setState] in [didUpdateWidget] are redundant.
    super.didUpdateWidget(oldWidget);
    _statedWidget.didUpdateWidget(oldWidget);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing either the values AppLifecycleState.paused or AppLifecycleState.resumed.
    _statedWidget.didChangeAppLifecycleState(state);
  }

  /// Called when a dependency of this [State] object changes.
  void didChangeDependencies() {
    super.didChangeDependencies();
    _statedWidget.didChangeDependencies();
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