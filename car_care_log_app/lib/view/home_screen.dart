// lib/views/home_screen.dart
import 'package:car_care_log_app/view/car_info_screen.dart';
import 'package:car_care_log_app/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/car_view_model.dart';
import 'add_car_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Care Log"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.green),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddCarScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CarViewModel>(
        builder: (context, carViewModel, child) {
          if (carViewModel.cars.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to your Car Care Log App!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Let's add your first car.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: carViewModel.cars.length,
              itemBuilder: (context, index) {
                final car = carViewModel.cars[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarInfoScreen(carId: car.id!)));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          // Background image for the card
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/gencar.png'), // Replace with your asset path
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Car Name and Status Icon
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                car.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8,
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            );
          }
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(selectedIndex: 0),
    );
  }
}
