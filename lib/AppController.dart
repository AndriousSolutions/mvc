import 'package:flutter/material.dart';
import 'package:mvc/AppView.dart';

///
///
/// 
///    Comtroller of the MVC design pattern.
///
/// Free to redistribute and/or modify.
/// http://www.apache.org/licenses/LICENSE-2.0
///                                     Andrious Solutions Ltd. 2018-03-25
///
class AppController extends _ControllerState with WidgetsBindingObserver {

  AppController() {
    // Should only be called once.
    if (instance == null) instance = this;
  }

  // Best to call the function, getStateInstance()
  static AppController instance;

  static AppController getStateInstance(){
    return instance;
  }


  reState(VoidCallback fn) {
    // Calls the 'real' setState()
    // setState() can only be called within this class.
    setState(fn);
  }

  refresh() {
    // Refresh the Widget Tree Interface
    setState(() {});
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. It might reinsert it into another part of the tree.
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  @override
  void deactivate() {
    super.deactivate();
  }

  /// The framework calls this method when this [State] object will never
  /// build again. The [State] object's lifecycle is terminated.
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  @override
  void dispose() {
    instance = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

  }
}

/// Most of the app’s code resides in this class.
/// This class maintains the 'state' (i.e. the running values) of the app.
class _ControllerState extends State<AppStatefulWidget> {

  AppView _vw;

  setView(AppView view) {
    assert(view != null, 'Must instaniate this class, ${this.runtimeType}, with an Appview parameter object!');
    _vw = view;
  }

  // Use 'widget' as well.
  get app => widget;

  @override
  Widget build(BuildContext context) {
    // It is an error to call this method after the framework calls [dispose].
    // You can determine whether it is legal to call this method by checking
    // whether the [mounted] property is true.
   if (!this.mounted) return new EmptyWidget(widget: this.widget);

    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    //
    // Generally it is recommended that the `setState` method only be used to
    // wrap the actual changes to the state, not any computation that might be
    // associated with the change.
    return _vw?.build(context);
  }
}


class AppStatefulWidget extends StatefulWidget {

  AppStatefulWidget(this.vw, [Key key]) : super(key: key ??= new ObjectKey(AppController?.instance));

  final AppView vw;

// This class is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values
// provided by the parent and used by the build method of the State.
// Fields in a Widget subclass are always marked "final"
  @override
  createState() => AppController.getStateInstance();
}



class EmptyWidget extends Widget{
  const EmptyWidget({this.widget, Key key}): super(key: key);

  final Widget widget;

  @override
  Element createElement(){

    return widget.createElement();
  }
}