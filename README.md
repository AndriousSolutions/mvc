# mvc
![Flutter + MVC](https://i.imgur.com/MdZJpMi.png)
###### The "Kiss" MVC Flutter Framework

In keeping with the ["KISS Principle"](https://en.wikipedia.org/wiki/KISS_principle), this was an attempt
to offer the MVC design pattern to Flutter in a simple 
and intrinsic fashion. Simply extend three classes---and you've then
the means to implement the Model-View-Controller Design Pattern.

**MVC** aims to decouple its three major components allowing
for efficient code reuse and parallel development. Each responsible
for separate tasks:

* Model - the Controller’s source for data
* View - concerned with how the data is displayed.
* Controller - what data is displayed. ("the brains of the operation.")

![MVC Diagram](https://i.imgur.com/r4C1y28.png)
Ideally, this design pattern would have the  code in the 'View' not directly
affect or interfere with the code involved in the 'Model' or vice versa.
While the 'Contoller', in this arrangement, controls the
current 'state' of the application and any direction
the application takes in its lifecycle.

Only four simple Classes in all are possibly involved with the intent here
to make the implementation of **MVC** in Flutter as intuitive as possible.
![4 Classes](https://i.imgur.com/BqxMSeP.png)


Simply inherit from the appropriate MVC Classes: 
AppModel, AppView and AppConntroller
Below, for example, are the subclasses of the three MVC Classes.
Now fill them up with what will make up your Flutter applcation
(the appropriate code in the appropriate Class), and you're done!
Model Class
![Model](https://i.imgur.com/mUIo8sq.png)
Controller Class
![Controller](https://i.imgur.com/BXM4Wl4.png)
View Class
![View](https://i.imgur.com/3N73L5D.png)

Implementing these Classes has Dependency Injection introduced in its purest form
with each **MVC** component appropriately passed to one another as parameters.
![App Run MVC Components](https://i.imgur.com/HsTWQmS.png)










In Flutter, its possible to 'try before you fork' by inserting
into your metadata file, **pubspec.yaml**, the git url to this repo.:
![mvc git url](https://i.imgur.com/gIc1ejh.png)


http://github.com - automatic!
[GitHub](http://github.com)

 ## Getting Started with Flutter

[Online Documentation](https://flutter.io/).