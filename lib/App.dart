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
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

import 'package:mvc/MVC.dart';

import 'LoadingScreen.dart';

import 'package:file_utils/files.dart';

import 'package:file_utils/InstallFile.dart';

import 'package:prefs/prefs.dart';

/// class Assets
import 'package:flutter/services.dart';



class App extends StatelessWidget {

  factory App(String title, MCView view,{Key key, MVCState state}){
    if(_this == null) _this = App._getInstance(title, view, key: key, state: state);
    return _this;
  }
  /// Make only one instance of this class.
  static App _this;

  App._getInstance(String title, MCView view,{Key key, MVCState state}) :
        _title = title ?? '',
        _vw = view,
        _state = state?.setView(view) ?? AppState.set(view),
        super(key: key);
  final String _title;
  final MCView _vw;
  final MVCState _state;



  @override
  Widget build(BuildContext context) {
    var app = MyApp(_vw, state: _state);
    return MaterialApp(
      title: _title,
      theme: MyApp.getThemeData(),
      home: FutureBuilder(
        future: app.init(),
        builder: (_, snapshot) {
          return snapshot.hasData ? app : LoadingScreen();
        },
      ),
    );
  }

  static final Connectivity _connectivity = new Connectivity();

  static StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static String _installNum;
  static get installNum => _installNum;

  static String _path;
  static get filesDir => _path;

  static String _connectivityStatus;
  static get connectivity => _connectivityStatus;

  static get isOnline => _connectivityStatus != 'none';

  static Set _listeners = new Set();



  static init(){

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

    initConnectivity()
        .then((status){_connectivityStatus = status;})
        .catchError((e){_connectivityStatus = 'none';});
  }



  /// Called in the State object's dispose() function.
  static void dispose(){

    _connectivitySubscription.cancel();
  }


  static Future<String> getInstallNum(){

    return InstallFile.id();
  }

  static Future<String> initConnectivity() async {
    String connectionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (ex) {
      connectionStatus = 'Failed to get connectivity.';
    }
    return connectionStatus;
  }



  static addConnectivityListener(ConnectivityListener listener){
    return _listeners.add(listener);
  }



  static removeConnectivityListener(ConnectivityListener listener){
    return _listeners.remove(listener);
  }



  static clearConnectivityListener(){
    return _listeners.clear();
  }



  bool get inDebugger {
    var inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}



abstract class ConnectivityListener{
  onConnectivityChanged(ConnectivityResult result);
}



class MyApp extends StatefulWidget {

  factory MyApp(MCView view,{Key key, AppState state}){
    if(_this == null) _this = MyApp._getInstance(view, key: key, state: state);
    return _this;
  }
  /// Make only one instance of this class.
  static MyApp _this;

  MyApp._getInstance(AppView view,{Key key, AppState state}) :
        _vw = view,
        _state = state.setView(view) ?? AppState.set(view),
        super(key: key);
  final AppView _vw;
  final AppState _state;



  @override
  State createState(){
    /// Pass this 'view' to the State object.
    return _state;
  }



  Future<bool> init() async{
    /// The default is to dump the error to the console.
    /// Instead, a custom function is called.
    FlutterError.onError = (FlutterErrorDetails details) async {
      await _reportError(details);
    };
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
}



/// Reports [error] along with its [stackTrace]
Future<Null> _reportError(FlutterErrorDetails details) async {
  // details.exception, details.stack
  FlutterError.dumpErrorToConsole(details);
}



/// Subclass the MVC State object.
class AppState extends MVCState {

  /// Allow for Mixins
  AppState(): super();



  AppState.set(AppView vw){
    _vw = vw;
    setView(vw);
  }
  AppView _vw;



  Future<bool> init() async {
    return Future.value(true);
  }



  @override
  void dispose(){
    Assets.dispose();
    _vw.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context){
    /// Get the Asset Managers
    Assets.init(context);
    return super.build(context);
  }
}


abstract class AppView extends MCView{

  AppView([this._con]): super(_con);

  AppController _con;

  @mustCallSuper
  Future<bool> init() async {
    return _con.init();
  }

  /// Override to dispose anything initialized in your init() function.
  void dispose(){
  }

  /// Provide 'the view'
  Widget build(BuildContext context);
}



class AppController extends MVController{

  /// Initialize any 'time-consuming' operations at the beginning.
  Future<bool> init() async {
    return Future.value(true);
  }
}


///
/// Asset Manager for the App
///
class Assets{


  static Future<bool> init(BuildContext context, {String dir}){
    _assets = DefaultAssetBundle.of(context);
    _dir = dir ?? 'assets';
    return Future.value(true);
  }
  static AssetBundle _assets;
  static String _dir;


  static dispose(){
    _assets = null;
  }

  

  static Future<ByteData> getStreamF(String key) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    ByteData data;
    try {
      data = await Assets._assets.load("$setPath(key)$key");
    }catch(ex){
      data = ByteData(0);
    }
    return data;
  }



  static Future<String> getStringF(String key,{bool cache = true}) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    String asset;
    try {
      asset = await Assets._assets.loadString("$setPath(key)$key", cache: cache);
    }catch(ex){
      asset = '';
    }
    return asset;
  }



  Future<T> getData<T>(String key, Future<T> parser(String value)) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    Future<T> data;
    try {
      data = Assets._assets.loadStructuredData("$setPath(key)$key", parser);
    }catch(ex){
      data = null;
    }
    return data;
  }



  Future<String> getStringData(String key, Future<String> parser(String value)) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    String data;
    try {
      data = await Assets._assets.loadStructuredData("$setPath(key)$key", parser);
    }catch(ex){
      data = null;
    }
    return data;
  }



  Future<bool> getBoolData(String key, Future<bool> parser(String value)) async {
    assert(Assets._assets != null, 'Assets.init() must be called first.');
    bool data;
    try {
      data = await Assets._assets.loadStructuredData("$setPath(key)$key", parser);
    }catch(ex){
      data = false;
    }
    return data;
  }


  AssetImage getImage(String key,{AssetBundle bundle,String package}){
    return AssetImage(key, bundle: bundle, package: package);
  }


  /// Determine the appropriate path for the asset.
  static String setPath(String key){
    /// In case 'assets' begins the key or if '/' begins the key.
    var path = key.indexOf(_dir) == 0 ? '' : key.substring(0,0) == '/' ? _dir : "$_dir/";
    return path;
  }
}


