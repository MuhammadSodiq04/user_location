import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_location/ui/map/widgets/address_kind_selector.dart';
import 'package:user_location/ui/map/widgets/address_lang_selector.dart';
import 'package:user_location/ui/map/widgets/save_button.dart';
import 'package:user_location/ui/user_locations/user_locations.dart';
import '../../data/model/user_address.dart';
import '../../providers/address_call_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/user_locations_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();

}
late CameraPosition currentCameraPosition;
class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  bool onCameraMoveStarted = false;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context, listen: false);

    initialCameraPosition = CameraPosition(
      target: locationProvider.latLong!,
      zoom: 20,
    );

    currentCameraPosition = CameraPosition(
      target: locationProvider.latLong!,
      zoom: 13,
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onCameraMove: (CameraPosition cameraPosition) {
              currentCameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              debugPrint(
                  "CURRENT CAMERA POSITION: ${currentCameraPosition.target.latitude}");

              context.read<AddressCallProvider>().getAddressByLatLong(latLng: currentCameraPosition.target);
              setState(() {
                onCameraMoveStarted = false;
              });

              debugPrint("MOVE FINISHED");
            },
            liteModeEnabled: false,
            myLocationEnabled: false,
            padding: const EdgeInsets.all(16),
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.terrain,
            onCameraMoveStarted: () {
              setState(() {
                onCameraMoveStarted = true;
              });
              debugPrint("MOVE STARTED");
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initialCameraPosition,
          ),
          Align(
            child: SizedBox(
              height: onCameraMoveStarted?80:50,
              child: Image.asset('assets/images/location_icon.png'),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
              child: Text(
                context.watch<AddressCallProvider>().scrolledAddressText,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 90),
              child: AddressLangSelector(),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:90,horizontal: 15),
              child: AddressKindSelector(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Material(
                borderRadius: BorderRadius.circular(100),
                child: Ink(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return UserLocationsScreen(onTap: () {
                          followMe(cameraPosition: currentCameraPosition);
                        });
                      }));
                    }, child: const Icon(Icons.table_rows),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Visibility(
                visible: context.watch<AddressCallProvider>().canSaveAddress(),
                child: SaveButton(onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text('Insert address name'),
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            TextField(
                              controller: context.read<AddressCallProvider>().textController,
                            ),
                            TextButton(
                                onPressed: (){
                                  if(context.read<AddressCallProvider>().textController.text.isNotEmpty){
                                AddressCallProvider adp = Provider.of<AddressCallProvider>(context, listen: false);
                                context.read<UserLocationsProvider>().insertUserAddress(
                                  UserAddress(
                                    lat: currentCameraPosition.target.latitude,
                                    long: currentCameraPosition.target.longitude,
                                    address: adp.scrolledAddressText,
                                    addressName: context.read<AddressCallProvider>().textController.text,
                                    created: DateTime.now().toString(),
                                  ),
                                );
                                Navigator.pop(context);
                                context.read<AddressCallProvider>().textController.text = '';
                                  }else{
                                    var snackBar = const SnackBar(content: Text('Empty Name'),);
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                            }, child: const Text('Save'))
                          ],
                        ),
                      ),
                    );
                  });
                },),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Material(
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              followMe(cameraPosition: initialCameraPosition);
            },
            child: const Icon(Icons.gps_fixed,size: 30,),
          ),
        ),
      ),
    );
  }

  Future<void> followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}