import 'package:nfc_mobile_prototype/features/home/screens/home_screen.dart';

class AppBlocState {
  final bool isTopCurtainEnabled;
  final bool isBottomCurtainEnabled;
  final bool isNetworkEnabled;

  final List<int> routes;

  const AppBlocState({
    required this.isTopCurtainEnabled,
    required this.isBottomCurtainEnabled,
    required this.isNetworkEnabled,
    required this.routes,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      isTopCurtainEnabled: false,
      isBottomCurtainEnabled: false,
      isNetworkEnabled: true,
      routes: [HomeScreen.screenIndex],
    );
  }

  AppBlocState update({
    bool? isTopCurtainEnabled,
    bool? isBottomCurtainEnabled,
    bool? isNetworkEnabled,
    List<int>? routes,
  }) {
    return AppBlocState(
      isTopCurtainEnabled: isTopCurtainEnabled ?? this.isTopCurtainEnabled,
      isBottomCurtainEnabled: isBottomCurtainEnabled ?? this.isBottomCurtainEnabled,
      isNetworkEnabled: isNetworkEnabled ?? this.isNetworkEnabled,
      routes: routes ?? this.routes,
    );
  }
}
