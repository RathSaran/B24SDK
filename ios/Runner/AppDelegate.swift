import UIKit
import Flutter
import B24PaymentSdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
      
//      let controller:FlutterViewController=window?.rootViewController as! FlutterViewController
//            let channel=FlutterMethodChannel(name: "merchant-sample.com/native", binaryMessenger:controller.binaryMessenger)
//            channel.setMethodCallHandler({
//                [weak self](call: FlutterMethodCall,result:FlutterResult)->Void in
//                guard call.method=="getSDK" else {
//                    result(FlutterMethodNotImplemented)
//                    return
//                }
//                
//                if let arguments=call.arguments as? [String:Any]{
//                    let tranNo=arguments["tranNo"] as? String
//                    let refererKey=arguments["refererKey"] as? String
//                    let language=arguments["language"] as? String
//                    let darkMode=arguments["darkMode"] as? Bool
//                    let production=arguments["production"] as? Bool
//                    
//                    B24PaymentSdk().initSdk(controller: controller, transactionId: tranNo ?? "BEDCBDCA55AC", refererKey: refererKey ?? "123X", language: language ?? "km", darkMode: darkMode!, isProduction: production!)
//                    
//                    if let text = tranNo, let text1 = refererKey {
//                                    // Call your method with the extracted values
//                        self?.getMessage(result: result, text: tranNo ?? "", text1: refererKey ?? "")
//                                } else {
//                                    // Handle the case when the keys are missing or have nil values
//                                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid argument values", details: nil))
//                                }
//                }
//                
//                
//            })

      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    
    
//    private func getMessage(result: FlutterResult, text: String, text1: String) {
//            // Your logic here...
//
//            // Example: Concatenate the two strings and send the result back to Flutter
//            let message = "Combined message: \(text) \(text1)"
//            
//            if message.isEmpty {
//                result(FlutterError(code: "UNAVAILABLE", message: "Message From Swift is empty", details: nil))
//            } else {
//                result(message)
//            }
//        }
}
