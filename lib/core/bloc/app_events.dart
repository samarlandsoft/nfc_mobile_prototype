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
