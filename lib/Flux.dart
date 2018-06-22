
import 'package:flutter/foundation.dart';

import 'package:flutter/widgets.dart';

abstract class DispatchWidget extends StatefulWidget{
   const DispatchWidget({
    this.stores,
    Key key}) : super(key: key);


  final List<Store> stores;

  /// Provide the 'tree of views'
  Widget build(BuildContext context);


  @override
  createState(){

    var state = new _FluxState(this, stores);

    for (var store in stores) {
      /// Get a reference of the State object for each Store.
      store.state = state;
    }

    return state;
  }



  void onPressed(Widget widget){

    for (var store in stores){

      try {

        store.onPressed(widget);

      } on Exception catch (ex){

      }
    }
  }


  void onTap(Widget widget){

    for (var store in stores){

      try {

        store.onTap(widget);

      } on Exception catch (ex){

      }
    }
  }
}


/// The State Object
class _FluxState extends State<DispatchWidget> with WidgetsBindingObserver  {
  _FluxState(
      this.widget,
      this._stores,
      ): assert(widget != null), assert(_stores != null);

  final DispatchWidget widget;

  final List<Store> _stores;

  @override
  void initState(){
    /// called when the [State] object is first created.
    super.initState();

    for (var store in _stores) {

      store.initState();
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void deactivate(){
    /// called when this [State] object is removed from the tree.

    for (var store in _stores) {

      store.deactivate();
    }
    super.deactivate();
  }

  @override
  void dispose(){
    /// called when this [State] object will never build again.
    WidgetsBinding.instance.removeObserver(this);

    for (var store in _stores) {

      store.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(DispatchWidget oldWidget) {
    /// Override this method to respond when the [widget] changes (e.g., to start
    /// implicit animations).
    /// The framework always calls [build] after calling [didUpdateWidget], which
    /// means any calls to [setState] in [didUpdateWidget] are redundant.
    super.didUpdateWidget(oldWidget);

    for (var store in _stores) {

      store.didUpdateWidget(oldWidget);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing either the values AppLifecycleState.paused or AppLifecycleState.resumed.
    for (var store in _stores) {

      store.didChangeAppLifecycleState(state);
    }
  }

  void reState(VoidCallback fn) {
    /// Calls the 'real' setState()
    /// setState() can only be called within this class.
    setState(fn);
  }

  /// The View
  Widget build(BuildContext context){
    /// Here's where the magic happens.
    return widget.build(context);
  }
}


///
///  Extend this class and instantiate with a factory constructor.
//class newStore extends Store{
//     factory newStore() {
//
//        if(_store == null){
//
//           _store = new newStore._getInstance();
//
//           return _store;
//        }else{
//
//           return _store;
//        }
//     }
//     static newStore _store;
//     newStore._getInstance();
//}
class Store{

  /// A reference to the State object.
  _FluxState state;

  /// Allow for the widget getter in the build() function.
  get widget => state?.widget;

  /// BuildContext is always useful in the build() function.
  get context => state?.context;

  /// Ensure the State Object is 'mounted' and not being terminated.
  get mounted => state?.mounted ?? false;
  

  void onPressed(Widget widget){

  }


  void onTap(Widget widget){

  }

  void initState(){

  }

  void deactivate(){

  }

  @mustCallSuper
  void dispose(){

    state = null;
  }

  void didUpdateWidget(DispatchWidget oldWidget) {

  }

  void didChangeAppLifecycleState(AppLifecycleState state) {

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





