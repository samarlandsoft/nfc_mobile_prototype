class AppBlocState {
  final int currentScreenIndex;
  final bool isCustomTheme;

  const AppBlocState({
    required this.currentScreenIndex,
    required this.isCustomTheme,
  });

  factory AppBlocState.initial() {
    return const AppBlocState(
      currentScreenIndex: 0,
      isCustomTheme: false,
    );
  }

  AppBlocState update({
    int? currentScreenIndex,
    bool? isCustomTheme,
  }) {
    return AppBlocState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      isCustomTheme: isCustomTheme ?? this.isCustomTheme,
    );
  }
}
