import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../data/model/user_address.dart';
import '../../providers/user_locations_provider.dart';
import '../map/map_screen.dart';

class UserLocationsScreen extends StatefulWidget {
  const UserLocationsScreen({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  State<UserLocationsScreen> createState() => _UserLocationsScreenState();
}

class _UserLocationsScreenState extends State<UserLocationsScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    List<UserAddress> userAddresses = Provider.of<UserLocationsProvider>(context).addresses;
    return Scaffold(
      appBar: AppBar(title: const Text("User Locations Screen"),
      actions: [
        IconButton(onPressed: (){
          context.read<UserLocationsProvider>().deleteAllAddress();
        }, icon: const Icon(Icons.delete,color: Colors.red,))
      ],
      ),
      body: ListView(
        children: [
          if (userAddresses.isEmpty) const Text("EMPTY!!!"),
          ...List.generate(userAddresses.length, (index) {
            UserAddress userAddress = userAddresses[index];
            return ListTile(
              onTap: (){
                currentCameraPosition = CameraPosition(target: LatLng(userAddress.lat,userAddress.long),zoom: 20);
                widget.onTap.call();
                Navigator.pop(context);
                },
              title: Text(userAddress.addressName),
              subtitle:
                  Text(userAddress.address),
            );
          })
        ],
      ),
    );
  }
}
