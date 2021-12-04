abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateScreenIndex extends AppBlocEvent {
  final int screenIndex;

  AppUpdateScreenIndex({required this.screenIndex}) : super([screenIndex]);
}

class AppUpdateWrapperCurtainMode extends AppBlocEvent {
  final bool isTopCurtainEnabled;
  final bool isBottomCurtainEnabled;
  final bool isCurtainOpacityEnabled;

  AppUpdateWrapperCurtainMode({
    required this.isTopCurtainEnabled,
    required this.isBottomCurtainEnabled,
    required this.isCurtainOpacityEnabled,
  }) : super([
          isTopCurtainEnabled,
          isBottomCurtainEnabled,
          isCurtainOpacityEnabled,
        ]);
}

class AppUpdateNetworkConnectionMode extends AppBlocEvent {
  final bool isNetworkEnabled;

  AppUpdateNetworkConnectionMode({required this.isNetworkEnabled})
      : super([isNetworkEnabled]);
}
