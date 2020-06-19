import 'package:geolocator/geolocator.dart';
import 'package:readyuser/models/vendor.dart';
import 'package:readyuser/shared/constants.dart';

class Operate{
  Future<List<Vendor>> sort(List<Vendor> input) async{
    var futures = <Future>[];
    input.removeWhere((element) => !element.isAvailable);
    input.forEach((element) {
      futures.add(Geolocator().
      distanceBetween(userLatitude, userLongitude, element.latitude, element.longitude).then((value) {
        //print(element.name+value.toString());
        return element.distance = value;
      }));
    });
    await Future.wait(futures);
    input.sort((a, b) => a.distance.compareTo(b.distance));
    //input.forEach((element) {print(element.name);});
    return input;
  }
}