import 'package:map_launcher/map_launcher.dart';

class Utils {
  static final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  static Future<void> launchMap(double latitude, double longitude) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      print(availableMaps);
      availableMaps.first
          .showDirections(destination: Coords(latitude, longitude));
    } catch (e) {}

    // await launch(url);
  }
}
