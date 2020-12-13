import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_imclient/model/im_constant.dart';
import 'package:image/image.dart';

import 'package:flutter_imclient/message/media_message_content.dart';
import 'package:flutter_imclient/message/message_content.dart';
import 'package:flutter_imclient/model/message_payload.dart';
import 'package:flutter_imclient/message/message.dart';

// ignore: non_constant_identifier_names
MessageContent LinkMessageContentCreator() {
  return new LinkMessageContent();
}

const linkContentMeta = MessageContentMeta(MESSAGE_CONTENT_TYPE_LINK,
    MessageFlag.PERSIST_AND_COUNT, LinkMessageContentCreator);

class LinkMessageContent extends MediaMessageContent {

  String title;
  String contentDigest;
  String url;
  String thumbnailUrl;

  @override
  MessageContentMeta get meta => linkContentMeta;

  @override
  void decode(MessagePayload payload) {
    super.decode(payload);
    title = payload.searchableContent;
    Map<dynamic, dynamic> map = json.decode(new String.fromCharCodes(payload.binaryContent));
    contentDigest = map['d'];
    url = map['u'];
    thumbnailUrl = map['t'];
  }

  @override
  Future<MessagePayload> encode() async {
    MessagePayload payload = await super.encode();

    payload.searchableContent = title;
    payload.binaryContent = new Uint8List.fromList(json.encode({'d':contentDigest, 'u':url, 't':thumbnailUrl}).codeUnits);
    return payload;
  }

  @override
  Future<String> digest(Message message) async {
    if(title != null && title.isNotEmpty) {
      return '[链接]:$title';
    }
    return '[链接]';
  }
}