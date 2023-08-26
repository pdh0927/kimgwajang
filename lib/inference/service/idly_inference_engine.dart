import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kimgwajang/inference/service/inference_engine.dart';

class IdlyGptInferenceEngine implements InferenceEngine {
  final Uri REQUEST_URI = Uri.parse('http://remote.beingidly.com:38532/');

  @override
  Future<String> inference(String argument) async {
    var completer = Completer<String>();
    var response = http.post(
      REQUEST_URI,
      body: argument,
    );

    response.then((response) {
      final decodeData = utf8.decode(response.bodyBytes);
      try {
        String result = decodeData;
        completer.complete(result);
      } catch (except) {
        completer.completeError(decodeData);
      }
    });

    return completer.future;
  }
}
