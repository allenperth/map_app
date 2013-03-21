// Copyright (c) 2012, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of google_maps_weather;

class WeatherFeature extends jsw.IsJsProxy {
  static final INSTANCIATOR = (js.Proxy jsProxy) => new WeatherFeature.fromJsProxy(jsProxy);

  WeatherFeature.fromJsProxy(js.Proxy jsProxy) : super.fromJsProxy(jsProxy);

  WeatherConditions get current => $.current.map(WeatherConditions.INSTANCIATOR).value;
  List<WeatherForecast> get forecast => $.forecast.map((js.Proxy jsProxy) => new jsw.JsList<WeatherForecast>.fromJsProxy(jsProxy, WeatherForecast.INSTANCIATOR)).value;
  String get location => $.location.value;
  TemperatureUnit get temperatureUnit => $.temperatureUnit.map(TemperatureUnit.find).value;
  WindSpeedUnit get windSpeedUnit => $.windSpeedUnit.map(WindSpeedUnit.find).value;
}