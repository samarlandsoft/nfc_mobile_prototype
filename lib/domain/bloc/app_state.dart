class AppState {
  final int index;
  final String tag;

  AppState({
    required this.index,
    this.tag = '',
  });

  AppState update({int? index, String? tag}) {
    return AppState(
      index: index ?? this.index,
      tag: tag ?? this.tag,
    );
  }
}
