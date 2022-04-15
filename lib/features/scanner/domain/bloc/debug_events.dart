abstract class DebugBlocEvent {
  const DebugBlocEvent([List props = const []]) : super();
}

class DebugUpdateData extends DebugBlocEvent {
  final String chipID;
  final String tokenID;
  final String md5Hash;

  DebugUpdateData({
    required this.chipID,
    required this.tokenID,
    required this.md5Hash,
  }) : super([chipID, tokenID, md5Hash]);
}
