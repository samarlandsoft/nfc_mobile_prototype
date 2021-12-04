class AppBlocState {
  final int currentScreenIndex;
  final bool isTopCurtainEnabled;
  final bool isBottomCurtainEnabled;
  final bool isCurtainOpacityEnabled;
  final bool isNetworkEnabled;

  const AppBlocState({
    required this.currentScreenIndex,
    required this.isTopCurtainEnabled,
    required this.isBottomCurtainEnabled,
    required this.isCurtainOpacityEnabled,
    required this.isNetworkEnabled,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      currentScreenIndex: 0,
      isTopCurtainEnabled: false,
      isBottomCurtainEnabled: false,
      isCurtainOpacityEnabled: false,
      isNetworkEnabled: true,
    );
  }

  AppBlocState update({
    int? currentScreenIndex,
    bool? isTopCurtainEnabled,
    bool? isBottomCurtainEnabled,
    bool? isCurtainOpacityEnabled,
    bool? isNetworkEnabled,
  }) {
    return AppBlocState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      isTopCurtainEnabled: isTopCurtainEnabled ?? this.isTopCurtainEnabled,
      isBottomCurtainEnabled: isBottomCurtainEnabled ?? this.isBottomCurtainEnabled,
      isCurtainOpacityEnabled: isCurtainOpacityEnabled ?? this.isCurtainOpacityEnabled,
      isNetworkEnabled: isNetworkEnabled ?? this.isNetworkEnabled,
    );
  }
}
