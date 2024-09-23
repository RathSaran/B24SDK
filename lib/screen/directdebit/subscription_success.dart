import 'package:flutter/material.dart';

class SubscriptionSuccess extends StatelessWidget {
  const SubscriptionSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription"),
      ),
      body: const Center(
        child: Text("Your Subscription Successfully"),
      ),
    );
  }
}
