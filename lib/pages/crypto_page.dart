import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoPage extends StatefulWidget {
  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  Future<List<dynamic>> getCryptoAssets() async {
    const url = 'https://api.coincap.io/v2/assets';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      late final List<dynamic> cryptoAssets = decodeData['data'];
      return cryptoAssets;
    } else {
      throw Exception('Failed to load data');
    }
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto App'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getCryptoAssets(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final dynamic cryptoAsset = snapshot.data;
              return ListView.builder(
                  itemCount: cryptoAsset.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(
                        cryptoAsset[index]['id'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        cryptoAsset[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        cryptoAsset[index]['symbol'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
