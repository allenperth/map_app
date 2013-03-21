//in order to use google map api dart version, js of client.dart is required that saying ultimately good map dart api is using js.
//generate js as long as client.dart changes
library client;

import 'dart:html';
import 'dart:json' as Json;
import 'dart:async';
import 'dart:uri';

import 'package:google_maps/js_wrap.dart' as jsw;
import 'package:google_maps/google_maps.dart';
import 'package:js/js.dart' as js;

part 'config.dart';

GMap map;
final LatLng centre = jsw.retain(new LatLng(-29.5,132.1));
//var uriXML = 'news.xml';
var markerIMG = 'combined.png';

InputElement usrTitle= query('#title');
TextAreaElement usrDesc = query('#description');
InputElement usrPhoto = query('#photo');
var usrTime =new DateTime.now().toLocal().toString();

String title = 'none';
String description = 'none';
String photo = 'none';
String time = 'none';
String ip = 'none';

var uri = 'news.json';

void main() {
 
  //load local JSON
  HttpRequest.getString(uri)
  .then(processString)
  .whenComplete(complete)
  .catchError(handleError);

  //responseJSON;
  /*
  query('#submit').onClick.listen((e){
  print("click");
  });
  */
  ajaxGetJSON;
  // Read an XML file.
  //receiveXML(uriXML);
  
  // Send JSON
  //ajaxSendJSON;
  
  // Load Google Map
  loadMap('dff', 'dfd', 'd3f', 'hhj', markerIMG);
}

complete()
{
  print('Complete:$title,$description,$photo,$time,$ip');
}

/*
void receiveXML(var xml) {
  HttpRequest.request(xml)
      .then(handleXML)
      .catchError(handleError);
}

void handleXML(HttpRequest request) {
  var xmlDoc = request.responseXml;
  try {
    title = xmlDoc.query('title').text;
    query('#title').$dom_setAttribute('value',title);
    
    description = xmlDoc.query('description').text;
    query('#description').$dom_setAttribute('value',description);
    
    //photo = xmlDoc.query('photo').text;
    time = xmlDoc.query('time').text;
    
  } catch(e) {
    print('$uriXML doesn\'t have correct XML formatting.');
  }
}

void handleError(AsyncError error) {
  print('Sending JSON Failed.');
  print(error.toString());
}
*/

processString(String jsonString) {
  var news = Json.parse(jsonString);
  print('json string:');
  print(jsonString);
  
  assert(news is List);
  var firstNews = news[0];
  assert(news[0] is Map);
  
  title = firstNews['title'];
  description = firstNews['description'];
  photo = firstNews['photo'];
  time = firstNews['time'];
  ip = firstNews['ip'];
  
  print('$title,$description,$photo,$time,$ip');
}
/*
void changeInputElemPlaceHolder(String eid, String evalue){
var elem = new InputElement();
elem.id = eid;
elem.name =eid;
elem.value = evalue;
query('#$eid').replaceWith(elem);
}

void changeTxtAreaElemPlaceHolder(String eid, String evalue){
var elem = new TextAreaElement();
elem.id = eid;
elem.name = eid;
elem.cols = 38;
elem.rows = 5;
elem.placeholder = evalue;
query('#$eid').replaceWith(elem);
}

void changeInputElemValue(String eid, String evalue){
var elem = new LocalDateTimeInputElement();
elem.id = eid;
elem.name =eid;
elem.value = evalue;
query('#$eid').replaceWith(elem);
}
*/
handleError(AsyncError error) {
  print('Uh oh, there was an error.');
  print(error.toString());
}

void responseJSON() {
  query("#submit").onClick.listen((e) {      
        HttpRequest.request("/news").then(
            (request) {
              Map jsoninfo = Json.parse(request.responseText);
          
              assert(jsoninfo is List);
              var firstNews = jsoninfo[0];
              assert(jsoninfo[0] is Map);
              
              print(jsoninfo is List);
            });
      });
  
  /*
  document.query("#submit").onClick.listen(
    (e) {
      HttpRequest.request("/server-info").then(
        (request) {
          Map news = Json.parse(request.responseText);
          title = news["title"];
          description = news["description"];
          photo = news["photo"];
          time = news["time"];;
        });
    });
    */
}

void loadMap(String vTitle, String vDescription, String vPhoto, String vUserTime, var MarkerImage) {
  
  js.scoped((){
    final mapOptions = new MapOptions()
      ..zoom = 4
      ..center = centre
      ..mapTypeId = MapTypeId.ROADMAP
      ;
    
    //var myLayer = new GLayer("org.wikipedia.en");
    map = jsw.retain(new GMap(query("#mapholder"), mapOptions));
    
    //clickable area
    var makerShape = new MarkerShape();
    makerShape.coords = [20,6,22,7,23,8,24,9,25,10,25,11,25,12,25,13,25,14,25,15,25,16,25,17,25,18,25,19,24,20,23,21,22,22,20,23,19,24,8,24,5,23,4,22,4,21,4,20,4,19,10,18,9,17,8,16,8,15,7,14,7,13,7,12,8,11,8,10,8,9,9,8,10,7,11,6,20,6];
    makerShape.type = MarkerShapeType.POLY;
    
    final markerIcon = new Icon()
    ..url = MarkerImage;
    
    var content = new DivElement();
    content.innerHtml='''
    <h3><b>$vTitle</b></h3>
    <p>$vDescription</p>
    <p>$vPhoto</p>
    <b>$vUserTime</b>
    ''';
    
    var marker1 = new Marker(new MarkerOptions()
    ..position = centre
    ..map = map
    ..draggable = false
    ..shape = makerShape
    ..animation = Animation.DROP
    ..icon = markerIcon
    );
    
    var infoWindow = new InfoWindow(
        new InfoWindowOptions()
        ..content = content
    );
    
    document.query('#time').text = "Date Time: $usrTime";
    
  
    marker1.on.mouseover.add((e) {
      infoWindow.open(map, marker1);
    });
    
    jsw.retainAll([map, marker1, makerShape, infoWindow]);
    
  });
}
/*

void ajaxSendJSON()
{
 HttpRequest request = new HttpRequest(); // create a new XHR
  
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) 
      {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      // data saved OK.
      print(request.responseText); // output the response from the server
      }
                                                         }
  );

  // POST the data to the server
  var url = "$HOST:$PORT/server-info";
  request.open("POST", url, false);
  try{
  request.send(mapTOJSON()); // perform the async POST
  }
  catch(e)
  {
    print('Sending data failed.');
  }
}


String mapTOJSON()
{
  var obj = new Map();
  obj["title"] = usrTitle.text==null? "none":usrTitle.text;
  obj["description"] = usrDesc.text==null? "none":usrDesc.text;
  obj["photo"] = usrPhoto.text==null? "none": usrPhoto.text;
  obj["time"] = usrTime==null? "none":usrTime; 
  return Json.stringify(obj); // convert map to String i.e. JSON
}
}
*/
void ajaxGetJSON(){
 
  var url = "$HOST:$PORT/news";
  // call the web server asynchronously
  var request = HttpRequest.getString(url).then(onDataLoaded);
}

// print the raw json response text from the server
void onDataLoaded(String responseText) {
  var news = Json.parse(responseText);
  print('json string:');
  print(responseText);
  
  assert(news is List);
  var firstNews = news[0];
  assert(news[0] is Map);
  
  title = firstNews['title'];
  description = firstNews['description'];
  photo = firstNews['photo'];
  time = firstNews['time'];
  ip = firstNews['ip'];
  print('transfommer');
}