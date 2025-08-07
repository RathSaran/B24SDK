import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_merchant_app_flutter/screen/Wallet/digital_wallet.dart';
import 'package:sample_merchant_app_flutter/screen/directdebit/direct_debit_screen.dart';
import 'package:sample_merchant_app_flutter/screen/directdebit/subscription_success.dart';
import 'package:sample_merchant_app_flutter/screen/home_screen.dart';
import 'package:sample_merchant_app_flutter/screen/success_screen.dart';

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  ));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) {
        return HomeScreenWallet();
      },
      routes: [
        GoRoute(
            path: 'success',
            builder: (_, state) {
              final tranNo = state.uri.queryParameters['tran_id'];
              if (tranNo != null && tranNo.isNotEmpty) {
                return SuccessScreen(
                  invoiceNo: tranNo,
                );
              }
              return const Scaffold();
            }),
        GoRoute(
            path: 'subscription',
            builder: (_, state) {
              return const SubscriptionSuccess();
              // final tranNo = state.uri.queryParameters['tran_id'];
              // if (tranNo != null && tranNo.isNotEmpty) {
              //   return SuccessScreen(
              //     invoiceNo: tranNo,
              //   );
              // }
              // return const Scaffold();
            }),
      ],
    ),
    GoRoute(
        path: '/detail',
        builder: (_, state) {
          final tranNo = state.uri.queryParameters['tran_id'];
          if (tranNo != null && tranNo.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Detail "),
              ),
              body: Center(
                child: Text(
                  "Detail Screen $tranNo",
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text("Detail Screen", style: TextStyle(fontSize: 22)),
            ),
          );
        }),
    GoRoute(
      path: '//page1',
      builder: (_, __) => HomeScreenWallet(), //wallet
    ),
    GoRoute(
      path: '//page2',
      builder: (_, __) => HomeScreen(), //deeplink
    ),
    GoRoute(
      path: '//page3',
      builder: (_, __) => InitDirectDebitScreen(), // ADD
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('Page not found')),
    );
  },
);
