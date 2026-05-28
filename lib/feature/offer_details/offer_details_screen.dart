import 'package:flutter/material.dart';
import 'package:flutter_challenge/util/styles.dart';
import 'package:get/get.dart';

/// INTENTIONAL GAP (Task A2): Screen is a stub — candidate implements full UI + controller.
class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offerId = Get.parameters['id'] ?? '';
    return Scaffold(
      appBar: AppBar(title: Text('offer_details'.tr)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.construction, size: 48),
              const SizedBox(height: 16),
              Text(
                'TODO: Implement offer details for id: $offerId',
                style: Styles.mediumText16(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'See CHALLENGE.md → Task A2',
                style: Styles.regularText14(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
