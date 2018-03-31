# mvc
![Flutter + MVC](https://i.imgur.com/MdZJpMi.png)
###### The "Kiss" of Flutter Frameworks

In keeping with the ["KISS Principle"](https://en.wikipedia.org/wiki/KISS_principle), this was an attempt
to offer the MVC design pattern to Flutter in a simple 
and intrinsic fashion. Simply extend three classes---and you've then
the means to implement the Model-View-Controller Design Pattern.

**MVC** aims to decouple its three major components allowing
for efficient code reuse and parallel development, each responsible
for separate tasks:

* Model - the Controller’s source for data
* View - concerned with how data is displayed.
* Controller - controls what data is displayed. ("the brains of the operation.")

Ideally, this design pattern would have the  code in the 'View' not directly
affect or interfere with the code involved in the 'Model' or vice versa.
While the 'Contoller', in this arrangement, controls the
'state' of the application during its lifecycle. The View can 'talk to' the Controller;
The Controller can 'talk to' the Model.

![MVC Diagram](https://i.imgur.com/r4C1y28.png)

Placed in your main.dart file, only four simple Classes in all are involved with the intent here
to make the implementation of **MVC** in Flutter as intuitive as possible.
Further notice how Dependency Injection is introduced in its purest form---with
each **MVC** component appropriately passed to one another as parameters.
![4 Classes](https://i.imgur.com/BqxMSeP.png)


Simply inherit from the three "KISS" MVC Classes: 
AppModel, AppView and AppConntroller

Below, for example, are subclasses of those three MVC Classes.
Now you fill them up with what will make up your Flutter applcation
(with the appropriate code in the appropriate Class), and you're done!

Model Class
![Model](https://i.imgur.com/mUIo8sq.png)
View Class
![View](https://i.imgur.com/3N73L5D.png)
Controller Class
![Controller](https://i.imgur.com/BXM4Wl4.png)


**Think of it this way...**
> The 'View' is the **build()** function.

> The 'Controller' is everything else.
                                  
## 'View' is the `build()` function
Like the traditional **build()** function, you have the 
**setState()** function. Further, if you place your 'View'
Class in a separate file (e.g. View.dart), you then can have
all your code responsible for the 'look and feel' in one place.
As well as as many top-level functions, top-level variables other
Classes you like, and all in one file.
## 'Controller' is `StatefulWidget` + `State<T extends StatefulWidget>`
And like the State object, you have access to the 
usual properties: **widget**, **context** and **mounted**. Further,
the Controller (and it's data info.) will persist between build() function calls like
the State object.










In Flutter, its possible to 'try before you fork' this repo by inserting
into your metadata file, **pubspec.yaml**, this git url:
![mvc git url](https://i.imgur.com/gIc1ejh.png)

![Exclaimation Point](https://i.imgur.com/KfdDFVK.png)
This repo will not last forever.(Nothing ever does.)Download it. Make it better. Then Share.
 ## Getting Started with Flutter

[Online Documentation](https://flutter.io/).