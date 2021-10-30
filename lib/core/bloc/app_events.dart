abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateScreenIndex extends AppBlocEvent {
  final int index;

  AppUpdateScreenIndex({required this.index}) : super([index]);
}

class AppUpdateUserRole extends AppBlocEvent {
  final bool isUserAdmin;

  AppUpdateUserRole({required this.isUserAdmin}) : super([isUserAdmin]);
}

class AppUpdateTheme extends AppBlocEvent {
  final bool isCustomTheme;

  AppUpdateTheme({required this.isCustomTheme}) : super([isCustomTheme]);
}
