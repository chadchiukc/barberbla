import 'package:barberbla/models/location_model.dart';
import 'package:barberbla/utils/gps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var _position = LocationModel().obs;

  get position => this._position.value?.lat;

  void getLocation() async {
    Position position = await GPS().determinePosition();
    _position.value =
        LocationModel(lat: position.latitude, lng: position.longitude);
  }
}
