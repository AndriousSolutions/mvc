///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  21 Jun 2018
///



import 'dart:async' show Future, StreamSubscription;

import 'package:flutter/material.dart' show StatefulWidget, AppLifecycleState, BoxDecoration, BuildContext, Color, Drawer, DrawerHeader, FlutterError, FlutterErrorDetails, FutureBuilder, GenerateAppTitle, GlobalKey, Key, ListTile, ListView, Locale, LocaleResolutionCallback, LocalizationsDelegate, MaterialApp, Navigator, NavigatorObserver, NavigatorState, RouteFactory, Scaffold, ScaffoldState, State, StatelessWidget, Text, Theme, ThemeData, TransitionBuilder, Widget, WidgetBuilder, mustCallSuper;

import 'package:connectivity/connectivity.dart' show Connectivity, ConnectivityResult;

import 'package:mvc/MVC.dart' show MCView, MVController, StatedWidget;

import 'package:file_utils/files.dart' show Files;

import 'package:file_utils/InstallFile.dart' show InstallFile;

import 'package:prefs/prefs.dart' show Prefs;

import 'package:auth/Auth.dart' show Auth;

import 'package:assets/Assets.dart' show Assets;

import 'package:flutter/widgets.dart' show AppLifecycleState;

import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;

import 'package:mvc/src/LoadingScreen.dart' show LoadingScreen;

import 'package:mvc/src/FireBase.dart' show FireBase;


class App extends StatelessWidget {

  factory App(AppView view,{Key key,
  }){
    if(_this == null){
      /// The default is to dump the error to the console.
      /// Instead, a custom function is called.
      FlutterError.onError = (FlutterErrorDetails details) async {
        await _reportError(details);
      };
      _this = App._getInstance(view, key);
    }
    return _this;
  }
  
  /// Make only one instance of this class.
  static App _this;

  App._getInstance(AppView view, Key key) :
        _vw = view,
        key = key,
        super(key: key){
    _app = MyApp(_vw);
  }

  final AppView _vw;
  final Key key;
  static MyApp _app;

  static BuildContext _context;
  static ThemeData _theme;
  static ScaffoldState _scaffold;

  @override
  Widget build(BuildContext context) {
    Assets.init(context);
    _context = context;
    return MaterialApp(
      key: key,
      navigatorKey: _vw.navigatorKey,
      routes: _vw.routes,
      initialRoute:  _vw.initialRoute,
      onGenerateRoute: _vw.onGenerateRoute,
      onUnknownRoute: _vw.onUnknownRoute,
      navigatorObservers: _vw.navigatorObservers,
      builder: _vw.builder,
      title: _vw.title,
      onGenerateTitle: _vw.onGenerateTitle,
      color: _vw.color,
      theme: _vw.theme ?? MyApp.getThemeData(),
      locale: _vw.locale,
      localizationsDelegates: _vw.localizationsDelegates,
      localeResolutionCallback: _vw.localeResolutionCallback,
      supportedLocales: _vw.supportedLocales,
      debugShowMaterialGrid: _vw.debugShowMaterialGrid,
      showPerformanceOverlay: _vw.showPerformanceOverlay,
      checkerboardRasterCacheImages: _vw.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _vw.checkerboardOffscreenLayers,
      showSemanticsDebugger: _vw.showSemanticsDebugger,
      debugShowCheckedModeBanner: _vw.debugShowCheckedModeBanner,
      home: FutureBuilder(
        future: _app.init(),
        builder: (_, snapshot) {
          return snapshot.hasData ? _app : LoadingScreen();
        },
      ),
    );
  }

  /// Called in the MyApp dispose() function.
  static void dispose(){
    _app.dispose();
    _context = null;
    _theme = null;
    _scaffold = null;
  }

  static Future<String> getInstallNum() => MyApp.getInstallNum();

  static addConnectivityListener(ConnectivityListener listener) => MyApp.addConnectivityListener(listener);

  static removeConnectivityListener(ConnectivityListener listener) => MyApp.removeConnectivityListener(listener);

  static clearConnectivityListener() => MyApp.clearConnectivityListener();

  static bool get inDebugger => MyApp.inDebugger;

  static ThemeData get theme => App._getTheme();
  static ThemeData _getTheme(){
    if(_theme == null) _theme = Theme.of(_context);
    return _theme;
  }

  static ScaffoldState get scaffold => App._getScaffold();
  static ScaffoldState _getScaffold(){
    if(_scaffold == null) _scaffold = Scaffold.of(_context, nullOk: true);
    return _scaffold;
  }
}






class MyApp extends StatefulWidget {

  factory MyApp(MCView view,{Key key}){
    if(_this == null) _this = MyApp._getInstance(view, key: key);
    return _this;
  }
  /// Make only one instance of this class.
  static MyApp _this;

  MyApp._getInstance(AppView view,{Key key}) :
        _vw = view,
        _state = view.con,
        super(key: key);
  
  final AppView _vw;
  final AppController _state;


  @override
  State createState(){
    /// Pass this 'view' to the State object.
    return _state;
  }



  /// Called in the State object's dispose() function.
  void dispose(){

    _vw.dispose();

    _connectivitySubscription.cancel();
    _connectivitySubscription = null;
  }



  Future<bool> init() async{

    _initInternal();

    return _vw.init();
  }



  static getThemeData() {

    Prefs.getStringF('theme').then((value){

      var theme = value ?? 'light';

      ThemeData themeData;

      switch (theme) {
        case 'light':
          themeData = ThemeData.light();
          break;
        case 'dark':
          themeData = ThemeData.dark();
          break;
        default:
          themeData = ThemeData.fallback();
      }
      return themeData;
    });
  }



  static setThemeData(String theme) {
    switch (theme) {
      case 'light':
        break;
      case 'dark':
        break;
      default:
        theme = 'fallback';
    }
    Prefs.setString('theme', theme);
  }


  static final Connectivity _connectivity = Connectivity();

  static StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static String _installNum;
  static get installNum => _installNum;

  static String _path;
  static get filesDir => _path;

  static String _connectivityStatus;
  static get connectivity => _connectivityStatus;

  static get isOnline => _connectivityStatus != 'none';

  static Set _listeners = new Set();


  
  /// Internal Initialization routines.
  static void _initInternal(){

    /// Get the installation number
    InstallFile.id()
        .then((id){_installNum = id;})
        .catchError((e){});

    /// Determine the location to the files directory.
    Files.localPath
        .then((path){_path = path;})
        .catchError((e){});

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          _listeners.forEach((listener){listener.onConnectivityChanged(result);});
        });

    _initConnectivity()
        .then((status){_connectivityStatus = status;})
        .catchError((e){_connectivityStatus = 'none';});
  }


  void didChangeAppLifecycleState(AppLifecycleState state) {
    FireBase.didChangeAppLifecycleState(state);
  }

  
  static Future<String> getInstallNum() => InstallFile.id();


  static Future<String> _initConnectivity() async {
      String connectionStatus;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        connectionStatus = (await _connectivity.checkConnectivity()).toString();
      } catch (ex) {
        connectionStatus = 'Failed to get connectivity.';
      }
      return connectionStatus;
    }


  static addConnectivityListener(ConnectivityListener listener) => _listeners.add(listener);


  static removeConnectivityListener(ConnectivityListener listener) => _listeners.remove(listener);


  static clearConnectivityListener() => _listeners.clear();


  static bool get inDebugger {
      var inDebugMode = false;
      assert(inDebugMode = true);
      return inDebugMode;
  }
}



abstract class ConnectivityListener{
  onConnectivityChanged(ConnectivityResult result);
}



/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack
  FlutterError.dumpErrorToConsole(details);
}



abstract class AppView extends MCView{

  AppView({
    this.con,
    this.navigatorKey,
    this.routes: const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers: const <NavigatorObserver>[],
    this.builder,
    this.title: '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.supportedLocales: const <Locale>[const Locale('en', 'US')],
    this.debugShowMaterialGrid: false,
    this.showPerformanceOverlay: false,
    this.checkerboardRasterCacheImages: false,
    this.checkerboardOffscreenLayers: false,
    this.showSemanticsDebugger: false,
    this.debugShowCheckedModeBanner: true,
  }): super(con);

  final AppController con;
  
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;
  final String initialRoute;
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final List<NavigatorObserver> navigatorObservers;
  final TransitionBuilder builder;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final ThemeData theme;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  @mustCallSuper
  Future<bool> init() {
    return con.init();
  }

  /// Override to dispose anything initialized in your init() function.
  @mustCallSuper
  void dispose(){
    con.dispose();
  }

  /// Provide 'the view'
  Widget build(BuildContext context);
}





class AppController extends MVController{


  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize items essential to the Mobile Applications.
  /// Called by the MyApp.init() function.
  Future<bool> init() async {
    Auth.init(listener: listener);
    Prefs.init();
    return Future.value(true);
  }


  /// Ensure certain objects are 'disposed.'
  /// Callec by the AppState.dispose() function.
  @override
  @mustCallSuper
  void dispose() {
    Auth.dispose();
    Prefs.dispose();
    App.dispose();
    Assets.dispose();
    super.dispose();
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
//    MyApp.didChangeAppLifecycleState(state);
  }


  /// Authentication listener
  listener(FirebaseUser user){

  }
}






class AppDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("DRAWER HEADER.."),
              decoration: new BoxDecoration(

              ),
            ),
            new ListTile(
              title: new Text("Item => 1"),
              onTap: () {
                Navigator.pop(context);
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) => new FirstPage()));
              },
            ),
            new ListTile(
              title: new Text("Item => 2"),
              onTap: () {
                Navigator.pop(context);
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) => new SecondPage()));
              },
            ),
          ],
        )
    );
  }
}




