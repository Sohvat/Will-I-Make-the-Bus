import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; 

class BusStop extends StatefulWidget {
  final Position userPosition;
  final double walkingSpeed;
  
  const BusStop({
    super.key,
    required this.userPosition,
    required this.walkingSpeed,
  });

  @override
  State<BusStop> createState() => _BusStopState();
}

class _BusStopState extends State<BusStop> {
  @override
  void initState() {
    super.initState();
    // Access the data using widget.userPosition and widget.walkingSpeed
    print('Lat: ${widget.userPosition.latitude}, Lng: ${widget.userPosition.longitude}');
    print('Speed: ${widget.walkingSpeed}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF192E59),
      appBar: AppBar(
        backgroundColor: Color(0xFF6c9ed0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Image.asset(
              'lib/images/logo.png',
              width: 80,
              height: 80,
            ),
            Text(
              'Will I Make the Bus?', 
              style: TextStyle(color: Colors.white),
            ),
          ],
        )  
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}