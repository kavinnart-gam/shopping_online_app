import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../view_model/home_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                QrImageView(
                  data: 'https://payment.spw.challenge/checkout?price=${homeProvider.getTotalPrice()}',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Scan & Pay",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Price: \$${homeProvider.getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
