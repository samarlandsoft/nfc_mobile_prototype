abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateScreenIndex extends AppBlocEvent {
  final int index;

  AppUpdateScreenIndex({required this.index}) : super([index]);
}

class AppUpdateTheme extends AppBlocEvent {
  final bool isCustomTheme;

  AppUpdateTheme({required this.isCustomTheme}) : super([isCustomTheme]);
}

class AppUpdateDebugMode extends AppBlocEvent {
  final bool isDebugEnabled;

  AppUpdateDebugMode({required this.isDebugEnabled}) : super([isDebugEnabled]);
}

class AppUpdateNetworkConnectionMode extends AppBlocEvent {
  final bool isNetworkEnabled;

  AppUpdateNetworkConnectionMode({required this.isNetworkEnabled}) : super([isNetworkEnabled]);
}

class AppUpdateSplashMode extends AppBlocEvent {
  final bool isSplashPlayed;

  AppUpdateSplashMode({required this.isSplashPlayed}) : super([isSplashPlayed]);
}
