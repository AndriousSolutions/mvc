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
///          Created  23 Jun 2018

import 'dart:async';

import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

import 'package:mvc/MVC.dart';

import 'package:file_utils/files.dart';

import 'package:file_utils/InstallFile.dart';

import 'package:prefs/prefs.dart';

import 'package:auth/Auth.dart';

import 'package:assets/Assets.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/widgets.dart' show AppLifecycleState;

import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;

class FireBase{

  static FirebaseDatabase _database;

  static DatabaseReference _reference;

  static FirebaseApp _app;

  
  static init() async {

    _app = await FirebaseApp.configure(
      name: 'working-memory-823375',
      options: Platform.isIOS
          ? const FirebaseOptions(
        googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
        gcmSenderID: '297855924061',
        databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
      )
          : const FirebaseOptions(
        googleAppID: '1:761477102089:android:ecbfc1109769ee45',
        apiKey: 'AIzaSyBpSv3EJpHCvQj4Qkur1X-Y3ooZWFo5i1E',
        databaseURL: 'https://working-memory-823375.firebaseio.com',
        storageBucket: 'working-memory-823375.appspot.com',
      ),
    );

    FireBase.setPersistenceEnabled(true);
  }



  static dispose(){
    FireBase.goOffline();
    _database = null;
    _reference = null;
  }



  static void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      FireBase.goOffline();
    }else{
      FireBase.goOnline();
    }
  }



  static DatabaseReference dataRef(String name) {
      return FireBase.reference()?.child(name);
  }



  static FirebaseApp get app => FireBase._getDB()?.app;



  static String get databaseURL => FireBase._getDB()?.databaseURL ?? 'unknown';



  static FirebaseDatabase get instance => FireBase._getDB();
  static FirebaseDatabase _getDB(){
    if(_database == null){

      _database = FirebaseDatabase(app: _app, databaseURL: 'https://working-memory-823375.firebaseio.com');

//      _app.options.then((options){
//        var settings = options;
//         var test = settings.databaseURL;
//      });

    }
    return _database;
  }


  FireBase();

  static DatabaseReference reference(){
    if(_reference == null) _reference = FireBase._getDB()?.reference();
    return _reference;
  }


  
  static bool get isPersistenceEnabled => _persistenceEnabled;
  static bool _persistenceEnabled;



  static Future<bool> setPersistenceEnabled(bool enabled) async {

    FirebaseDatabase db = FireBase._getDB();

    _persistenceEnabled = await db?.setPersistenceEnabled(enabled);

    _persistenceEnabled = _persistenceEnabled ?? false;

    return Future.value(_persistenceEnabled);
  }


  static Future<bool> setPersistenceCacheSizeBytes(int cacheSize) => FireBase._getDB()?.setPersistenceCacheSizeBytes(cacheSize) ?? Future.value(false);



  static Future<void> goOnline() => FireBase._getDB()?.goOnline();



  static Future<void> goOffline() => _database != null ? FireBase._getDB()?.goOffline() : Future.value();



  static Future<void> purgeOutstandingWrites() => FireBase._getDB()?.purgeOutstandingWrites();
}


