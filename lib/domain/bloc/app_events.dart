abstract class AppEvent {
  const AppEvent([List props = const []]) : super();
}

class AppUpdateIndex extends AppEvent {
  final int index;

  AppUpdateIndex({required this.index}) : super([index]);
}