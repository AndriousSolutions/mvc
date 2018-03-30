# mvc
![Flutter + MVC](https://i.imgur.com/MdZJpMi.png)
###### The "Kiss" MVC Flutter Framework

In keeping with the ["KISS Principle"](https://en.wikipedia.org/wiki/KISS_principle), this was an attempt
to offer the MVC design pattern to Flutter in a simple 
and intrinsic fashion.

**MVC** aims to decouple its three major components allowing
for efficient code reuse and parallel development. Each responsible
for they're separate tasks:

* Model - the Controller’s source for data
* View - concerned with how the data is displayed.
* Controller - the brains of the operation.

![MVC Diagram](https://i.imgur.com/r4C1y28.png)

Only four simple Classes involved, the intent here is 
to make the implementation of **MVC** as intuitive as possible.
![4 Classes](https://i.imgur.com/BqxMSeP.png)


Simply inherit from the appropriate MVC componment Classes: 
AppModel, AppView and AppConntroller
![Model](https://i.imgur.com/mUIo8sq.png)
![Controller](https://i.imgur.com/BXM4Wl4.png)
![View](https://i.imgur.com/3N73L5D.png)


Dependency Injection is introduced in its purest form:
Each **MVC** component is passed to each other as parameters.
![App Run MVC Components](https://i.imgur.com/HsTWQmS.png)










In Flutter, its possible to 'try before you fork' by inserting
into your metadata file, **pubspec.yaml**, the git url to this repo.:
![mvc git url](https://i.imgur.com/gIc1ejh.png)


http://github.com - automatic!
[GitHub](http://github.com)

 ## Getting Started with Flutter

[Online Documentation](https://flutter.io/).