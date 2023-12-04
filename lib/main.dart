import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_merchant_app_flutter/screen/home_screen.dart';
import 'package:sample_merchant_app_flutter/screen/success_screen.dart';

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
  ));
}

final router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (_, __) {
        return HomeScreen();
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
            })
      ]),
]);
