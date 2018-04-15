import 'package:mvc/AppModel.dart' show AppModel;
import 'Controller.dart';

/// Model Class
///
class Model extends AppModel {



  setCon(Controller con){

    _con = con;
  }

  Controller _con;
}
