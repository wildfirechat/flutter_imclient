import 'dart:typed_data';

import 'package:flutter_imclient/message/message.dart';
import 'package:flutter_imclient/message/message_content.dart';
import 'package:flutter_imclient/message/notification/notification_message_content.dart';
import 'package:flutter_imclient/model/message_payload.dart';

// ignore: non_constant_identifier_names
MessageContent DeleteMessageContentCreator() {
  return new DeleteMessageContent();
}
const deleteMessageContentMeta = MessageContentMeta(MESSAGE_CONTENT_TYPE_DELETE,
    MessageFlag.NOT_PERSIST, DeleteMessageContentCreator);

class DeleteMessageContent extends NotificationMessageContent {
  String operatorId;
  int messageUid;

  @override
  Future<Function> decode(MessagePayload payload) async {
    super.decode(payload);
    operatorId = payload.content;
    messageUid = int.parse(new String.fromCharCodes(payload.binaryContent));
  }

  @override
  MessageContentMeta get meta => deleteMessageContentMeta;

  @override
  Future<String> formatNotification(Message message) async {
    return null;
  }

  @override
  Future<MessagePayload> encode() async {
    MessagePayload payload = await super.encode();
    payload.content = operatorId;
    payload.binaryContent = new Uint8List.fromList(messageUid.toString().codeUnits);
    return payload;
  }

  @override
  Future<String> digest(Message message) async {
    return null;
  }
}