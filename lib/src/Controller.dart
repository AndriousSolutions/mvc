import 'package:mvc/AppController.dart' show AppController;
import 'Model.dart' show Model;

/// Control Class
///
class Controller extends AppController{

  Controller(this.mod){

    mod.setCon(this);
  }
  
  final Model mod;

}
