//import 'package:flutter_libserialport/flutter_libserialport.dart';
class ConnectionManager {
  String id = "My Device";
  bool connectionStatus = false;

  ConnectionManager();

  void checkConnection() {
    /// TODO: Ping Device and look for ack
    this.connectionStatus = false;
  }

  List<String> getAvailbeDevices() {
    //print(SerialPor.availablePorts);
    return ["Device 1", "Device 2"];
  }

  void connectToDevice(String deviceId) {
    print(deviceId);

    /// TODO: Connect to Device
  }
}
