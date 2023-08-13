import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_location/ui/map/map_screen.dart';
import '../../providers/location_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const MapScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    if (locationProvider.latLong != null) {
      _init();
    }
    return Scaffold(
      body: Center(child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          return Image.asset('assets/images/logo.png');
        },
      )),
    );
  }
}
