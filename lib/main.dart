
import 'package:flutter/material.dart';
import 'package:w3b_app/onBoading/onBoarding.dart';
import 'package:w3b_app/pages/homePage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const HomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//     final _w3mService = W3MService(
//     projectId: '1e5858852751aacc2eb8a4db9cd01df9',
//     metadata: const PairingMetadata(
//       name: 'Web3Modal Flutter Example',
//       description: 'Web3Modal Flutter Example',
//       url: 'https://www.walletconnect.com/',
//       icons: ['https://walletconnect.com/walletconnect-logo.png'],
//       redirect: Redirect(
//         native: 'flutterdapp://',
//         universal: 'https://www.walletconnect.com',
//       ),
//     ),
//   );
//    @override
//   void initState() {
//     super.initState();
//     _w3mService.init();
//   }
//  Future<void> callReadFunction() async {
//     try {
//       final deployedContract = DeployedContract(
//         ContractAbi.fromJson(
//           jsonEncode([
//             {
//               "inputs": [],
//               "stateMutability": "nonpayable",
//               "type": "constructor"
//             },
//             {
//               "inputs": [],
//               "name": "getVoteAlpha",
//               "outputs": [
//                 {"internalType": "int256", "name": "", "type": "int256"}
//               ],
//               "stateMutability": "view",
//               "type": "function"
//             },
//             {
//               "inputs": [],
//               "name": "getVoteBeta",
//               "outputs": [
//                 {"internalType": "int256", "name": "", "type": "int256"}
//               ],
//               "stateMutability": "view",
//               "type": "function"
//             },
//             {
//               "inputs": [],
//               "name": "voteAlpha",
//               "outputs": [],
//               "stateMutability": "nonpayable",
//               "type": "function"
//             },
//             {
//               "inputs": [],
//               "name": "voteBeta",
//               "outputs": [],
//               "stateMutability": "nonpayable",
//               "type": "function"
//             }
//           ]),
//           'vote',
//         ),
//         EthereumAddress.fromHex('0x47Ef1B29184430037cE317B4c47161aD5B93C668'),
//       );

//       var result = requestReadContract(
//         deployedContract: deployedContract,
//         functionName: 'getVoteAlpha',
//         rpcUrl: 'https://sepolia.etherscan.io/',
//         parameters: [],
//       );
//       print('Result:$result');
//     } catch (e) {
//       print(e);
//     }
//   }


//  requestReadContract({
//   required DeployedContract deployedContract,
//   required String functionName,
//   required String rpcUrl,
//   List<dynamic> parameters = const [],
// }) async {
//   // Logique pour lire depuis le smart contract et retourner le résultat
//   // Implémentez la logique pour interagir avec Web3dart et effectuer la lecture depuis le smart contract
// }


//   @override
//   Widget build(BuildContext context) {
   
//     return Container(color: Colors.white,);
//   }
// }
