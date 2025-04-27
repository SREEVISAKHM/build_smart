// Mock response data
import 'dart:math';

class MockData {
  static final Map<String, List<String>> _responses = {
    'greeting': [
      "Hello! How can I assist you today?",
      "Welcome back! What can I help you with?",
      "Hi there! I'm ready to help."
    ],
    'question': [
      "That's an interesting question. Let me think about it...",
      "I've been considering your question carefully.",
      "Here's what I found regarding your question."
    ],
    'confirmation': [
      "I've processed your request successfully.",
      "Your request has been completed.",
      "All done! Is there anything else you need?"
    ],
    'error': [
      "I'm sorry, I couldn't process that request.",
      "There seems to be an issue with that request.",
      "I encountered an error while processing your request."
    ]
  };

  static String getRandomResponse(String category) {
    final responses = _responses[category] ?? _responses['greeting']!;
    return responses[Random().nextInt(responses.length)];
  }
}
