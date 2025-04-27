import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  final String id;
  final String text;
  final bool isUser;
  final String timestamp;
  ChatModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  ChatModel copyWith({
    String? id,
    String? text,
    bool? isUser,
    String? timestamp,
  }) {
    return ChatModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.isUser == isUser &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ isUser.hashCode ^ timestamp.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      text: map['text'] as String,
      isUser: map['isUser'] as bool,
      timestamp: map['timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
