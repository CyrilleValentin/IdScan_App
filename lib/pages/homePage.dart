import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }
 
  void _initializeService() async {
    W3MChainPresets.chains.putIfAbsent('11155111', () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: "1e5858852751aacc2eb8a4db9cd01df9",
      logLevel: LogLevel.error,
      metadata: const PairingMetadata(
        name: "W3M Flutter",
        description: "W3M Flutter test app",
        url: 'https://www.walletconnect.com/',
        icons: ['https://web3modal.com/images/rpc-illustration.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }
   @override
  void dispose() {
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        W3MConnectWalletButton(service: _w3mService),
        W3MNetworkSelectButton(service: _w3mService),
        W3MAccountButton(service: _w3mService),
      ],
    );
  }
}
const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  namespace: 'eip155:$_chainId',
  chainId: _chainId,
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);
