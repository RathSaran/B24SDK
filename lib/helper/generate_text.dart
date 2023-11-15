import 'dart:convert';
import 'dart:math';

class Generate{
  static String generateText(){
    final random=Random();
    final randomString=String.fromCharCodes(
      List.generate(15, (index) => random.nextInt(26)+65),

    );
    final base64String=base64Encode(utf8.encode(randomString));

    return base64String;
  }
}