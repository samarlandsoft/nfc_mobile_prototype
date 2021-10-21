abstract class AppEvent {
  const AppEvent([List props = const []]) : super();
}

class AppUpdateIndex extends AppEvent {
  final int index;

  AppUpdateIndex({required this.index}) : super([index]);
}

class AppReadTag extends AppEvent {
  final String tag;

  AppReadTag({required this.tag}) : super([tag]);
}