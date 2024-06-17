// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:w3b_app/configs/constants/contract.dart';
import 'package:w3b_app/configs/routes/navigator.dart';
import 'package:w3b_app/pages/profile.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final qrCodekey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void result() {
    if (barcode != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Qr code Scanner'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(bottom: 10, child: buildResult()),
          Positioned(top: 10, child: buildControlBtn()),
        ],
      ),
    ));
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrCodekey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 10, borderLength: 20, borderRadius: 6),
      );
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        barcode = scanData;
      });
      await controller.pauseCamera();
      final ipfsHash = extractIpfsHash("${barcode?.code}");
      print('hash:$ipfsHash');
      bool isValid = await checkDocumentValidity(ipfsHash);
      print('reponse:$isValid');
      if (isValid==true) {
        QuickAlert.show(
          context: context,
          title: 'Succès',
          type: QuickAlertType.success,
          text: 'Carte Authentique!!',
          confirmBtnText: 'Détails',
          onConfirmBtnTap: () async {
            final data = await fetchDataFromUrl('${barcode?.code}');
            print("response:$data");
           navigatorSimple(context, Profile(data: data));
          },
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Echec...',
          text: 'Carte non Authentique!!',
          confirmBtnText: 'Réessayer',
          onConfirmBtnTap: () {
            navigatorDelete(context, const ScanPage());
          },
        );
      }
    });
  }

  String extractIpfsHash(String url) {
    final regex =
        RegExp('https://fuchsia-definite-fowl-804.mypinata.cloud/ipfs/(.*)');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      throw ArgumentError('Le lien fourni ne contient pas le préfixe attendu');
    }
  }

  Future<dynamic> fetchDataFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while fetching data: $e');
    }
  }

  Widget buildControlBtn() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.flash_off),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              icon: const Icon(Icons.switch_camera),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            )
          ],
        ),
      );

  Widget buildResult() => Text(
        barcode != null ? "Resultat: ${barcode?.code}" : "Resultat",
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
      );
}


