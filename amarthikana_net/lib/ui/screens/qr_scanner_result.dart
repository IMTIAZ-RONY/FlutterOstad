import 'package:amarthikana_net/ui/screens/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return QRScanner();
                  },
                ));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          "Scanned Result",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              QrImageView(
                data: "",
                size: 300,
                version: QrVersions.auto,
              ),
              const Text(
                "Scanned QR",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                code,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade900
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                    },
                    child: const Text(
                      "Copy",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}