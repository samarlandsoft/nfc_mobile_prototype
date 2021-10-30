class AppBlocState {
  final int currentScreenIndex;
  final bool isUserAdmin;
  final bool isCustomTheme;

  AppBlocState({
    this.currentScreenIndex = 0,
    this.isUserAdmin = true,
    this.isCustomTheme = false,
  });

  AppBlocState update({
    int? currentScreenIndex,
    bool? isUserAdmin,
    bool? isCustomTheme,
  }) {
    return AppBlocState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      isUserAdmin: isUserAdmin ?? this.isUserAdmin,
      isCustomTheme: isCustomTheme ?? this.isCustomTheme,
    );
  }
}
