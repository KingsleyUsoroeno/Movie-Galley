# movies

A new Flutter application.

## Getting Started

So i started my Flutter Adventure a little over a year ago and ever since then its been an amazing journey learning how to use these amazing framework to create cross-platfrom applications for both Android and IOS.
While learning much about flutter, i ran into so many conversations regarding using a clean Architecture to modularise and build out a flutter project using a combination and following a wide variety of state management tools that flutter has to offer such as Bloc, Provider, Mobx etc.
These movie App is highly inspired by resocoder Test Driven Development Architecture course which can be found [here](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/)
It Uses the Movie Db Api to fetch movies from its remote counterpart and saves it in a local database using the [Sqflite](https://pub.dev/packages/sqflite) Flutter plugin, while setting up these project i had no idea about [moor](https://pub.dev/packages/moor), which is a Room Like Database for flutter which i would higly recommend for my next project as well as upgrading the network package which is being used to another package such as [Dio](https://pub.dev/packages/dio).
Anyways the App is split up into different packages and offeres functionalities such as lazy Loading list pagination, offline storage and Search Implemention using flutters search Delegate widget.

## Libraries used
* Http read more about it [here](https://pub.dev/packages/http)
* Sqflite read more about it [here](https://pub.dev/packages/sqflite)
* Bloc for state management read more [here](https://pub.dev/packages/flutter_bloc)
* Dependency injection using the Get_it library
* and lots more


## Screenshots
<p float="left">
  <img src="https://github.com/KingsleyUsoroeno/Flutter-Movies-Upstream/blob/master/screenshots/home_screen.png" width="300" />
  <img src="https://github.com/KingsleyUsoroeno/Flutter-Movies-Upstream/blob/master/screenshots/kissing_booth_detail_screen.png" width="300" /> 
  <img src="https://github.com/KingsleyUsoroeno/Flutter-Movies-Upstream/blob/master/screenshots/scooby_detailed_screen.png"   width="300" />
</p>

<p float="left">
  <img src="https://github.com/KingsleyUsoroeno/Flutter-Movies-Upstream/blob/master/screenshots/search_result.png" width="300" />
</p>
