// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:vibration/vibration.dart';
import 'package:w3b_app/configs/constants/constant.dart';
import 'package:w3b_app/configs/routes/navigator.dart';
import 'package:w3b_app/pages/scan.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
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
    // Subscribe to modal connect event
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
            title: const Text("Vous n'etes pas éligible à scanner"),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingSlider(
        centerBackground: true,
        headerBackgroundColor: const Color.fromARGB(255, 231, 230, 234),
        pageBackgroundGradient: const LinearGradient(colors: [
          Color.fromARGB(255, 28, 125, 96),
          Color.fromARGB(255, 132, 93, 239),
        ], transform: GradientRotation(12)),
        // finishButtonText: 'Register',
        // onFinish: () {
        //   navigatorDelete(context, const ScanPage());
        // },

        skipTextButton: const Text('Skip'),
        background: [
          Lottie.asset(loti2,
              width: 400,
              height: 450,
              fit: BoxFit.fill,
              alignment: AlignmentDirectional.center),
          Lottie.asset(loti1,
              width: 400,
              height: 450,
              fit: BoxFit.fill,
              alignment: Alignment.center),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text(
                  "Sécurisez vos vérifications d'identité avec notre application de scan blockchain.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                const Text(
                  'Scannez en toute sécurité avec notre application blockchain.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(
                  height: 20,
                ),
                W3MConnectWalletButton(
                  service: _w3mService,
                ),
              ],
            ),
          ),
        ],
      ),
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
