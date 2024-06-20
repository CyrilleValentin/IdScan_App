// ignore_for_file: use_build_context_synchronously

import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:vibration/vibration.dart';
import 'package:w3b_app/configs/constants/constants.dart';
import 'package:w3b_app/configs/constants/contract.dart';
import 'package:w3b_app/configs/routes/navigator.dart';
import 'package:w3b_app/pages/scan.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class OnboardingOverview extends StatefulWidget {
  const OnboardingOverview({super.key});

  @override
  State<OnboardingOverview> createState() => _OnboardingOverviewState();
}

class _OnboardingOverviewState extends State<OnboardingOverview> {
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
    _w3mService.onModalConnect.subscribe((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        print('address=${event!.session.address}');
        final result = await interactWithContract('${event.session.address}');
        print(result);
        print('Type of result: ${result.runtimeType}');
        if (result[0] == true) {
          navigatorDelete(context, const ScanPage());
        } else {
          Vibration.vibrate(duration: 500, amplitude: 100);
          toastification.show(
            type: ToastificationType.error,
            context: context,
            style: ToastificationStyle.fillColored,
            title: const Text("You're not able to scan!!"),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _w3mService.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoOnboarding(
      bottomButtonColor: Colors.white,
      bottomButtonChild: W3MConnectWalletButton(
        service: _w3mService,
      ),
      onPressedOnLastPage: () => Navigator.pop(context),
      pages: [
        WhatsNewPage(
          scrollPhysics: const BouncingScrollPhysics(),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(logo, width: 150, height: 150),
              ),
              const SizedBox(height: 10),
              const Text(
                onboard,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF08B9ED)),
              ),
            ],
          ),
          features: const [
            WhatsNewFeature(
              title: Text("Security"),
              description: Text(
                  "Secure your identity verifications with our blockchain scanning application."),
              icon: Icon(
                CupertinoIcons.lock_rotation,
                color: Color(0xFF08B9ED),
              ),
            ),
            WhatsNewFeature(
              title: Text("Security"),
              description: Text(
                  "Secure your identity verifications with our blockchain scanning application."),
              icon: Icon(
                CupertinoIcons.lock_rotation,
                color: Color(0xFF08B9ED),
              ),
            ),
            WhatsNewFeature(
              title: Text('Style Flexiblity'),
              description: Text("Scan securely with our blockchain app. "),
              icon: Icon(CupertinoIcons.gear, color: Color(0xFF08B9ED)),
            ),
          ],
        ),
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
