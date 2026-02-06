import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.crypto,
    required this.bitcoinValueIn,
    required this.selectedCurrency,
  });

  final String crypto;
  final String bitcoinValueIn;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.surface.withOpacity(0.85),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: scheme.outline.withOpacity(0.35), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Text(
          '1 $crypto = $bitcoinValueIn $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
