class AppBlocState {
  final int currentScreenIndex;

  AppBlocState({
    this.currentScreenIndex = 0,
  });

  AppBlocState update({int? index}) {
    return AppBlocState(
      currentScreenIndex: index ?? currentScreenIndex,
    );
  }
}
