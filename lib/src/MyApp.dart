import 'package:mvc/App.dart' show App;
import 'View.dart' show View;
import 'Controller.dart' show Controller;
import 'Model.dart' show Model;

/// App Class
///
class MyApp extends App{

  MyApp(): super(new View(new Controller(new Model())));
}