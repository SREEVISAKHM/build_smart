import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show Random;

import 'package:build_smart/config/app_config.dart';
import 'package:build_smart/core/network/api_exceptions.dart';
import 'package:build_smart/features/dashboard/model/manual_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkServices {
  final _controller = StreamController<String>();

  Stream<String?> get messageStream => _controller.stream;

  void sendUserMessage(String userMessage) {
    final responses = [
      "That's interesting! Tell me more.",
      "Sure, I'll help you with that.",
      "Could you please clarify?",
      "Here's what I found!",
      "Absolutely! Let's dive deeper.",
      "Sounds good, let's proceed."
    ];
    final random = Random();
    final randomReply = responses[random.nextInt(responses.length)];

    _sendWordByWord(randomReply);
  }

  void _sendWordByWord(String message) async {
    String baseurl = AppConfig.baseUrl;
    log(baseurl, name: 'Base URL');
    final words = message.split(' ');
    String currentMessage = '';

    try {
      for (var word in words) {
        await Future.delayed(Duration(
            milliseconds:
                200 + Random().nextInt(400))); // Random delay 200ms - 600ms
        currentMessage += (currentMessage.isEmpty ? '' : ' ') + word;
        _controller.add(currentMessage);
      }
    } catch (e) {
      _controller.addError(ApiException.network());
    }
  }

  void dispose() {
    _controller.close();
  }

  Future<ManualModel> getManual() async {
    ManualModel manualModel = ManualModel(
      downloadUrl: 'downloadUrl',
      image: [
        'https://agcofca-media.s3.us-west-1.amazonaws.com/wp-content/uploads/2024/01/12084029/BuildSmart-Law.jpg',
        'https://dcassetcdn.com/design_img/3667825/716600/716600_21188772_3667825_d5edc95c_image.jpg',
        'https://cdn.prod.website-files.com/64f9d166374676995d39173b/65f8c9b70e21c1ca8c90914c_The%20Future%20of%20Smart%20Construction%20Sites-p-1600.webp',
        'https://hexagon.com/-/media/project/one-web/master-site/altudo/l1269/pod_data_800x428.jpg?h=428&iar=0&w=800&hash=68AC06D3D5BF81DDC6221D3370BF99FC',
        'https://www.onindus.com/wp-content/uploads/2024/04/7922.jpg'
      ],
    );
    try {
      const String baseUrl = AppConfig.baseUrl;

      log(baseUrl, name: 'Base Url');

      return manualModel;
    } on SocketException catch (e) {
      log(e.message, name: 'network error');
      throw ApiException.network();
    } catch (e) {
      throw ApiException.unknown();
    }
  }
}

final networkProvider = Provider<NetworkServices>((ref) {
  return NetworkServices();
});
