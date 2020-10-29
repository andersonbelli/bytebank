import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
//    final List<Transaction> transactions = List();
//    for (Map<String, dynamic> transactionJson in decodedJson) {
//      transactions.add(Transaction.fromJson(transactionJson));
//    }
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    // await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(baseUrl,
        headers: {
          "Content-type": "application/json",
          "password": password.toString()
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    print(response.statusCode);

    throw HttpException(_getMessage(response.statusCode)).message;
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode))
      return _statusCodeResponses[statusCode];

    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Error code 400',
    401: 'Authentication error',
    409: 'Transaction already exists',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
