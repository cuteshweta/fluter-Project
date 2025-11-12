import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
    ].request();

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
      return;
    }
    if (status[Permission.location]!.isGranted) {
      return;
    } else {
      requestPermission();
    }
  }
}
