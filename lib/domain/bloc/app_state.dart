class AppState {
  final int index;

  AppState({required this.index});

  AppState update({int? index}) {
    return AppState(
      index: index ?? this.index,
    );
  }
}