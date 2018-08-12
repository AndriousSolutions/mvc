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

library app_flutter;

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




part 'src/App.dart';
part 'src/FireBase.dart';
part 'src/LoadingScreen.dart';