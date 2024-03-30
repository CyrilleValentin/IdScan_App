// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
     controller.scannedDataStream.listen((scanData) {
      setState(() {
        barcode = scanData;
      });
    });
  }

  Widget buildControlBtn() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white
    ),
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
