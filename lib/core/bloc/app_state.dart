class AppBlocState {
  final int currentScreenIndex;
  final bool isCustomTheme;
  final bool isDebugEnabled;
  final bool isNetworkEnabled;
  final bool isSplashPlayed;

  const AppBlocState({
    required this.currentScreenIndex,
    required this.isCustomTheme,
    required this.isDebugEnabled,
    required this.isNetworkEnabled,
    required this.isSplashPlayed,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      currentScreenIndex: 0,
      isCustomTheme: false,
      isDebugEnabled: false,
      isNetworkEnabled: true,
      isSplashPlayed: false,
    );
  }

  AppBlocState update({
    int? currentScreenIndex,
    bool? isCustomTheme,
    bool? isDebugEnabled,
    bool? isNetworkEnabled,
    bool? isSplashPlayed,
  }) {
    return AppBlocState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      isCustomTheme: isCustomTheme ?? this.isCustomTheme,
      isDebugEnabled: isDebugEnabled ?? this.isDebugEnabled,
      isNetworkEnabled: isNetworkEnabled ?? this.isNetworkEnabled,
      isSplashPlayed: isSplashPlayed ?? this.isSplashPlayed,
    );
  }
}
