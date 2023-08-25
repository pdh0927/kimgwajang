import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kimgwajang/inference/service/inference_engine.dart';

class ChatGptInferenceEngine implements InferenceEngine {
  final String apiKey = dotenv.env['CHAT_GPT_API_KEY']!;
  final Uri REQUEST_URI =
      Uri.parse('https://api.openai.com/v1/chat/completions');

  @override
  Future<String> inference(String argument) async {
    var completer = Completer<String>();
    var response = http.post(
      REQUEST_URI,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode({
        'model': "gpt-3.5-turbo",
        'messages': [
          {"role": "user", "content": argument}
        ],
      }),
    );

    response.then((response) {
      final decodeData = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodeData);
      try {
        String result = data['choices'][0]['message']['content'];
        completer.complete(result);
      } catch (except) {
        completer.completeError(data);
      }
    });

    return completer.future;
  }
}
