import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the file containing your FirebaseOptions
import 'auth_screen.dart'; // Import the authentication screen
import 'report_screen.dart'; // Import the report screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          '/auth', // Set the initial route to the authentication screen
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/report': (context) => const ReportScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xddfcbba6),
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text('Dashboard',
              style: TextStyle(color: Color(0xff000000), fontSize: 20)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add your onPressed functionality here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add your onPressed functionality here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(24.619341816682663, 73.8547429409812),
                    zoom: 16.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(24.619341816682663, 73.8547429409812),
                          builder: (BuildContext context) {
                            return const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 30,
                            );
                          },
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              child: const Text('View Map'),
            ),
            const SizedBox(height: 24),
            Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/smartBin.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Status: 65% Full',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Last Updated: 02-09-2024 04:14',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/report');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  side: const BorderSide(color: Colors.blue, width: 2),
                ),
                child: const Text('Report Problem'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(24.619341816682663, 73.8547429409812),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(24.619341816682663, 73.8547429409812),
                builder: (context) => const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
