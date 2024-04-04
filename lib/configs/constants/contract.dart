import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:w3b_app/configs/constants/constants.dart';
import 'package:web3dart/web3dart.dart';

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
  
  String abiString = await loadContractABI();

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


Future<bool> checkDocumentValidity(String searchString) async {
 String abiString = await loadContractABI();

  final contract = DeployedContract(
    ContractAbi.fromJson(abiString, 'MyContract'),
    EthereumAddress.fromHex('0xef33214bd7dca5fb1a14e631e32a6e2273ff8d1a'),
  );

  final result = await ethClient.call(
    contract: contract,
    function: contract.function('checkIsValidDocumentId'),
    params: [searchString],
  );

  // Traitez le résultat de l'appel de fonction
  return result[0];
}

