import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart';

import 'package:flutter_imclient/message/media_message_content.dart';
import 'package:flutter_imclient/message/message_content.dart';
import 'package:flutter_imclient/model/message_payload.dart';
import 'package:flutter_imclient/message/message.dart';

// ignore: non_constant_identifier_names
MessageContent StickerMessageContentCreator() {
  return new StickerMessageContent();
}

const stickerContentMeta = MessageContentMeta(MESSAGE_CONTENT_TYPE_STICKER,
    MessageFlag.PERSIST_AND_COUNT, StickerMessageContentCreator);


class StickerMessageContent extends MediaMessageContent {
  int width;
  int height;

  @override
  MessageContentMeta get meta => stickerContentMeta;

  @override
  void decode(MessagePayload payload) {
    super.decode(payload);
    Map<dynamic, dynamic> map = json.decode(new String.fromCharCodes(payload.binaryContent));
    width = map['x'];
    height = map['y'];
  }

  @override
  Future<MessagePayload> encode() async {
    MessagePayload payload = await super.encode();
    payload.searchableContent = '[动态表情]';
    payload.binaryContent = new Uint8List.fromList(json.encode({'x':width, 'y':height}).codeUnits);
    return payload;
  }

  @override
  Future<String> digest(Message message) async {
    return '[动态表情]';
  }

  @override
  MediaType get mediaType => MediaType.Media_Type_STICKER;
}