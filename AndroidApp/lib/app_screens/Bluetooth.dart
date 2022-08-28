import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nfc_rfid/app_screens/HomePage.dart';
import 'dart:async';
import 'package:nfc_rfid/utils/BluetoothDeviceList.dart';


class Bluetooth extends StatefulWidget {

  final bool start;

  const Bluetooth({this.start = true});


  @override
  _BluetoothState createState() => _BluetoothState();
}


class _BluetoothState extends State<Bluetooth> {

  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
  List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  _BluetoothState();

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          setState(() {
            final existingIndex = results.indexWhere(
                    (element) => element.device.address == r.device.address);
            if (existingIndex >= 0) {
              results[existingIndex] = r;
            } else {
              results.add(r);
            }
          });
        });

    _streamSubscription?.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (setState after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? const Text('Discovering devices')
            : const Text('Discovered devices'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.replay),
            onPressed: _restartDiscovery,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          final device = result.device;
          final address = device.address;
          return BluetoothDeviceList(
            device: device,
            rssi: result.rssi,
            onTap: () {
              _startMainPage(context, result.device);
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (device.isBonded) {
                  print('Unbonding from ${device.address}...');
                  await FlutterBluetoothSerial.instance
                      .removeDeviceBondWithAddress(address);
                  print('Unbonding from ${device.address} has succeed');
                } else {
                  print('Bonding with ${device.address}...');
                  bonded = (await FlutterBluetoothSerial.instance
                      .bondDeviceAtAddress(address))!;
                  print(
                      'Bonding with ${device.address} has ${bonded ? 'succeed' : 'failed'}.');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                      device: BluetoothDevice(
                        name: device.name ?? '',
                        address: address,
                        type: device.type,
                        bondState: bonded
                            ? BluetoothBondState.bonded
                            : BluetoothBondState.none,
                      ),
                      rssi: result.rssi);
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occurred while bonding'),
                      content: Text(ex.toString()),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );

        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       BluetoothDiscoveryResult fakeResult = results[0];
      //       _startMainPage(context, fakeResult.device);
      //     },
      //     backgroundColor: Colors.green,
      //     child: const Icon(Icons.arrow_forward))
    );
  }

  void _startMainPage(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }


}