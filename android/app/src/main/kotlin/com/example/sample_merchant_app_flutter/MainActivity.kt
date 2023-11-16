package com.example.sample_merchant_app_flutter

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
//    private val CHANNEL="merchant-sample.com/native";
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler {
//                call, result ->
//
//                if(call.method=="getSDK"){
//                    val tranNo=call.argument<String>("tranNo")
//                    val refererKey=call.argument<String>("refererKey")
//                    val language=call.argument<String>("language")
//                    val darkMode=call.argument<Boolean>("darkMode")
//                    val  production=call.argument<Boolean>("production")
//
//                    if (darkMode != null && production !=null) {
//
//                        B24PaymentSdk.initSdk(supportFragmentManager,tranNo,refererKey,language,darkMode,production)
//                    }
//                }
//        }
//    }
}
