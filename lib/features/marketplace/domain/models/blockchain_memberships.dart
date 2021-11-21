import 'package:web3dart/web3dart.dart';

class BlockchainOwnerships {
  final EthereumAddress payer;
  final EthereumAddress nft;
  final BigInt tokenID;
  final int blockNum;

  const BlockchainOwnerships({
    required this.payer,
    required this.nft,
    required this.tokenID,
    required this.blockNum,
  });
}
