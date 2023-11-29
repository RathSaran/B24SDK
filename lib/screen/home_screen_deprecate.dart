import 'package:flutter/material.dart';
import 'package:sample_merchant_app_flutter/const/currency_code.dart';
import 'package:sample_merchant_app_flutter/core/request.dart';
import 'package:sample_merchant_app_flutter/helper/generate_text.dart';
import 'package:sample_merchant_app_flutter/model/customer.dart';
import 'package:sample_merchant_app_flutter/model/transaction_response.dart';
import 'package:sample_merchant_app_flutter/model/transactionv2.dart';
import 'package:sample_merchant_app_flutter/widget/button_widget.dart';
import 'package:sample_merchant_app_flutter/widget/input_text_widget.dart';


enum Currency{khr,usd}
enum ThemeMode{darkMode,lightMode}
enum Language{km,en}


class HomeScreenDeprecate extends StatefulWidget {

  @override
  State<HomeScreenDeprecate> createState() => _HomeScreenDeprecateState();
}

class _HomeScreenDeprecateState extends State<HomeScreenDeprecate> {
  final _amountController=TextEditingController();
  final _userRefController=TextEditingController();
  final _tokenController=TextEditingController(text: "AAAA");
  Currency? _currency=Currency.khr;
  ThemeMode? _themeMode=ThemeMode.lightMode;
  Language? _language=Language.km;

  String currency="KHR";
  bool themMode=true;
  String language="km";

 Future<TransactionResponse?> initTransactionV2Async() async{
    String identityCode=Generate.generateText();
    DateTime now=DateTime.now();

    Customer customer=Customer(
      branchCode: "01", 
      branchName: "BBB", 
      customerCode: "C01", 
      customerName: "BOT", 
      customerNameLatin: "BOT",
       billNo: "123", 
       amount: double.parse(_amountController.text));

   List<Customer> customers=[
    customer
   ];
      

    TransactionV2 transaction=TransactionV2(
      identityCode: identityCode, 
      purposeOfTransaction: now.toString(), 
      deviceCode: "1", 
      description: "description", 
      currency: currency, 
      amount:double.parse(_amountController.text), 
      language: language, 
      cancelUrl: "",
      redirectUrl: "https://bill24.com.kh/", 
      channelCode: "CH1",
      userRef: _userRefController.text, 
      customers: customers);

   return RequestAPI.initTranV2Async(transaction, customer);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Home Screen"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //amount
            //   InputTextWidget(
            //     controller: _amountController,
            //     label: "amount",
            //     inputType: TextInputType.number,
      
            //   ),
      
            // const SizedBox(height: 10,),
            // //user ref
            // InputTextWidget
            // (
            // label: "user ref", 
            // inputType: TextInputType.text, 
            // controller: _userRefController),
              //currency
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Radio<Currency>(
                      value: Currency.khr,
                      groupValue: _currency,
                      onChanged: (value){
                        setState(() {
                          _currency=value;
                          currency=CurrencyCode.khr;
                        });
                      },
                    ),
                    const Text(CurrencyCode.khr)
                      ],
                    ),
                    Row(
                      children: [
                        Radio<Currency>(
                      value: Currency.usd,
                      groupValue: _currency,
                      onChanged: (value){
                        setState(() {
                          _currency=value;
                          currency=CurrencyCode.usd;
                        });
                      },
                    ),
                    const Text(CurrencyCode.usd)
                      ],
                    )
                    
                  ],
                ),
              ),
              //theme mode 
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Radio<ThemeMode>(
                      value: ThemeMode.lightMode,
                      groupValue: _themeMode,
                      onChanged: (value){
                        setState(() {
                          _themeMode=value;
                          themMode=true;
                        });
                      },
                    ),
                    const Text("Light Mode")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<ThemeMode>(
                      value: ThemeMode.darkMode,
                      groupValue: _themeMode,
                      onChanged: (value){
                        setState(() {
                          _themeMode=value;
                          themMode=false;
                        });
                      },
                    ),
                    const Text("Dark Mode")
                      ],
                    )
                  ],
                ),
              ),

              //language
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Radio<Language>(
                      value: Language.km,
                      groupValue: _language,
                      onChanged: (value){
                        setState(() {
                          _language=value;
                          language="km";
                        });
                      },
                    ),
                    const Text("Khmer")
                      ],
                    ),
                    Row(
                      children: [
                        Radio<Language>(
                      value: Language.en,
                      groupValue: _language,
                      onChanged: (value){
                        setState(() {
                          _language=value;
                          language="en";
                        });
                      },
                    ),
                    const Text("English")
                      ],
                    )
                  ],
                ),
              ),
      
             //token

            //  SizedBox(
            //   height: 46,
            //    child: TextField(
            //     controller: _tokenController,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8)
            //       )
            //     ),
            //    ),
            //  ),
          const SizedBox(height: 10,),
            //button checkout
              // ButtonWidget(
              //   color: Colors.green, 
              //   name: "Checkout", 
              //   callback: () async{

              //    TransactionResponse? tran=await initTransactionV2Async();
                 
              //     // B24PaymentSdk.intSdk(
              //     // controller: context, 
              //     // tranId: tran!.data.tranId, 
              //     // refererKey: "123X",
              //     // darkMode: themMode,
              //     // language: language
              //     // );

              //   })
            ],
          ),
        ),
      ),
    );
  }
}