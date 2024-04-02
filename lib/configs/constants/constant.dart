import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

const String loti1 = "lotties/loti1.json";
const String loti2 = "lotties/loti2.json";
const String abi = "assets/contract_abi.json";

// Replace YOUR_INFURA_PROJECT_ID with your Infura project ID
String infuraProjectId = '205071a497c2419685eba87dd2214653';

// Create an instance of HttpClient
final client = http.Client();

// Create an instance of Web3Client with Sepolia testnet
final ethClient = Web3Client('https://sepolia.infura.io/v3/$infuraProjectId', client);

Future<String> loadContractABI() async {
  String abiString = await rootBundle.loadString(abi);
  List<dynamic> abiJson = jsonDecode(abiString);
  String abiJsonString = jsonEncode(abiJson);
  return abiJsonString;
}


Future<dynamic> interactWithContract(String address) async {
  // Chargez l'ABI du contrat intelligent
  String abiString = await loadContractABI();

  // Créez une instance de DeployedContract en utilisant l'ABI et l'adresse du contrat
  final contract = DeployedContract(
    ContractAbi.fromJson(abiString, 'MyContract'),
    EthereumAddress.fromHex('0xef33214bd7dca5fb1a14e631e32a6e2273ff8d1a'),
  );

  // Créez une instance de Web3Ethereum en utilisant votre fournisseur Ethereum préféré
final ethClient = Web3Client('https://sepolia.infura.io/v3/$infuraProjectId', client);

  // Interagissez avec le contrat intelligent en utilisant l'instance de DeployedContract
  final result = await ethClient.call(
    contract: contract,
    function: contract.function('checkisVerifier'),
    params: [EthereumAddress.fromHex(address)],
  );

  // Traitez le résultat de l'appel de fonction
  return result;
}

  void vibrate() {
  HapticFeedback.vibrate();
  Future.delayed(const Duration(seconds: 15), () {
    HapticFeedback.selectionClick();
  });
}
