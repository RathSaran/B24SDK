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
  ),
  GoRoute(
      path: '/success/:tranNo',
      builder: (_, state) {
        final tranNo = state.pathParameters['tranNo'].toString();
        return SuccessScreen(
          invoiceNo: tranNo,
        );
      })
]);
