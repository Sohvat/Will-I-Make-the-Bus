import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:will_i_make_the_bus/bus_stop.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Position? userPosition;
  double? walkingSpeed;
  String? error;
  bool location = false;
  bool _busStops = false;

  Future<void> getLocation() async {
    try {
      final position = await _getUserLocation();
      setState(() {
        userPosition = position;
        location = true;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  Future<Position> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _showCustomSpeedDialog() {
  TextEditingController speedController = TextEditingController();
  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enter Your Walking Speed'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: speedController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Speed (m/s)',
              hintText: 'e.g., 1.2',
              suffixText: 'm/s',
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final input = speedController.text.trim();
            if (input.isNotEmpty) {
              final speed = double.tryParse(input);
              if (speed != null && speed > 0 && speed < 10) {
                // Reasonable walking speed check
                setState(() => walkingSpeed = speed);
                Navigator.pop(context);
              } else {
                // Show error within dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid speed (0.1 - 9.9 m/s)'),
                  ),
                );
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

  @override
Widget build(BuildContext context) {
  if(_busStops == true){
    return BusStop();
  }else{
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
              if(location != true)
                Center(
                  child: Text( 
                  'To find nearby bus stops:',
                  style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                                ),
                ),
              
              const SizedBox(height: 20),
              if (userPosition == null)
                Center(
                  child: ElevatedButton(
                    onPressed: getLocation,
                    child: const Text(
                      'Allow Location Access',
                      style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                                ),
                ),
          
              if (userPosition != null && walkingSpeed == null) ...[
                Center(
                  child: Column(
                    children:[
                    const SizedBox(height: 20),
                    const Text(
                      'Do you know your walking speed?',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                            
                    ElevatedButton(
                      onPressed: () => _showCustomSpeedDialog(),
                      child: const Text(
                        'Yes, enter my speed',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    
                    
                    const Text(
                      'Or choose a standard speed:',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => setState(() => walkingSpeed = 0.9),
                          child: const Text(
                            'Slow',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() => walkingSpeed = 1.3),
                          child: const Text(
                            'Average',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() => walkingSpeed = 1.6),
                          child: const Text(
                            'Fast',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  ) 
                ),
              ],
              
              
              if (userPosition != null && walkingSpeed != null) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _busStops = true;
                    });
                  },
                  child: const Text(
                    'Find Nearby Bus Stops',
                    style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                    ),
                  ),
                ),
              ],
              
              if (error != null) ...[
                const SizedBox(height: 20),
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
  }
  
}
}
