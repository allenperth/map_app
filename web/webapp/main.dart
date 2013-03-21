//Server
library server;

import "dart:io";
import "dart:json" as Json;
import "package:stream/stream.dart";
import 'package:xml/xml.dart' as xml;

part "config.dart";
part "home.rsp.dart";
part "serverInfo.dart";

class NewsInfo {
  String title;
  String description;
  String photo;
  String time;
  
  NewsInfo(this.title, this.description, this.photo, this.time);
}

void main() {
  new StreamServer(uriMapping: _mapping).start();
}
