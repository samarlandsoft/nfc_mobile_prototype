import 'package:http/http.dart';
import 'package:nfc_mobile_prototype/core/services/logger.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  static const _infura_rpc_url =
      "https://mainnet.infura.io/v3/cf0b58d90da3413a8bd02e75a6d79e89";
  static const _infura_jwt =
      "qheWk2th7PypXhPtJGw5TtfKjcmTH3BqKbm7cVu4726WaEMe38NUCGXuRZCLFhjpFkDa2CtekgrVHCSvx9fQ6HPHvzjKaWrsYFS2KtZ9uXGGYd8FyrKrgTCFSvjSPE5PRxq29f2bq8HaP8eR4MekDGNbUDEPxkxgs9cdKqFkYyDGECQ39vUw3UfreAam4QttTpvgvMn2zrU8QVBL7JKYSxHEF3WLMn6NZ8kGsUGzc2rRgqWfhVBzmJUYmYUg4Qg2";
  static const _saltandsatoshi_seller_contract_abi =
      '[{"inputs":[{"internalType":"uint256","name":"_initialPrice","type":"uint256"},{"internalType":"uint256","name":"_priceStep","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[],"name":"Pause","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"payee","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"balance","type":"uint256"}],"name":"Sent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"payer","type":"address"},{"indexed":true,"internalType":"address","name":"nftAddress","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"TokenPurchase","type":"event"},{"anonymous":false,"inputs":[],"name":"Unpause","type":"event"},{"inputs":[],"name":"currentPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"destroy","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"priceStep","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_nftAddress","type":"address"},{"internalType":"uint256","name":"_tokenId","type":"uint256"}],"name":"purchaseToken","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_payee","type":"address"},{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"sendTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unpause","outputs":[],"stateMutability":"nonpayable","type":"function"}]';
  static const _saltandsatoshi_seller_contract_btc =
      "0xf6aA869d2A727565cC85eC90D8497aE72B3E0a4f";
  static const _saltandsatoshi_seller_contract_eth =
      "0x400a31ba7e9d428040b20eabdb329e54124f4013";

  final _httpClient = HttpClientWithCustomHeaders(headers: {});

  Future<void> getCurrentPrice() async {
    logDebug('BlockchainService -> getBalance()');

    // INIT WEB3
    // var web3 = new WEB3_DART.Web3Client(INFURA_RPC_URL, new HttpClientWithCustomHeaders({
    //   "Authorization": "Bearer ${INFURA_JWT}",
    // }));

    // GET MY ETH BALANCE
    // var myAddress = WEB3_DART.EthereumAddress.fromHex("0xC5Ddcb2812dd0D6a61a94310E4AA57c5122438Ca");
    // var balance = await web3.getBalance(myAddress);
    // print(balance.getValueInUnit(WEB3_DART.EtherUnit.ether));

    final web3 = Web3Client(_infura_rpc_url, _httpClient);
    final sellerContractAddress =
        EthereumAddress.fromHex(_saltandsatoshi_seller_contract_btc);
    final sellerContract = DeployedContract(
      ContractAbi.fromJson(_saltandsatoshi_seller_contract_abi, 'Seller'),
      sellerContractAddress,
    );

    final getCurrentPriceFunction = sellerContract.function('currentPrice');
    final currentPriceResult = await web3.call(
        contract: sellerContract, function: getCurrentPriceFunction, params: []);

    BigInt currentPriceAsBigInt = currentPriceResult[0];
    EtherAmount currentPrice = EtherAmount.inWei(currentPriceAsBigInt);

    logDebug('Current price: ${currentPrice.getValueInUnit(EtherUnit.ether)}');

    await web3.dispose();
  }
}

class HttpClientWithCustomHeaders extends BaseClient {
  final _httpClient = Client();
  final Map<String, String> headers;

  HttpClientWithCustomHeaders({required this.headers});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);
    return _httpClient.send(request);
  }
}
