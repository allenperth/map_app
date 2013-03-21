part of server;

var uriXML = 'news.xml';
var vTitle;
var vDescription;
var vPhoto;
var vTime;

void serverInfo(HttpConnect connect) {
  final info = {"title": "Allen", "description": "HelloWorld", "photo": "sss", "time": "2013", "ip":"21.23.44.2"};
  connect.response
    ..headers.contentType = contentTypes["json"]
    ..addString(Json.stringify(info));
  connect.close();
}
/*
void serverInfo(HttpConnect connect, NewsInfo news) {
  // Read an XML file.
  //handleXML(uriXML);
  //print("vDescription");
  //final info = {"title": vTitle, "description": vDescription, "photo": vPhoto, "time": vTime};
  final info = {"title": news.title, "description": news.description, "photo": news.photo, "time": news.time};
  connect.response
    ..headers.contentType = contentTypes["json"]
    ..addString(Json.stringify(info));
  connect.close();
}
*/
void handleXML(var xmlDoc) {
  
  try {
    vTitle = xmlDoc.query('title').text;
    vDescription = xmlDoc.query('description').text;
    vPhoto = xmlDoc.query('photo').text;
    vTime = xmlDoc.query('time').text;
    
  } catch(e) {
    print('$uriXML doesn\'t have correct XML formatting.');
  }
}
