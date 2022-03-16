import 'package:carptoapp/pages/crypto_page.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,

          ),
          home:  CryptoPage(),
    );
  }
}