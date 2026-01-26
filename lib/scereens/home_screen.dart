import 'package:flutter/material.dart';
import '../data/tourist_data.dart';
import '../models/tourist_place.dart';
import '../utils/app_colors.dart';
import '../utils/app_spaces.dart';
import '../utils/extensions.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TouristPlace> places = getPlaces();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saudi Tourist App'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      places[index].mainImage,
                      width: context.width,
                      height: context.width * 0.5,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: context.width * 0.5,
                          color: Colors.grey[300],
                          child: const Center(child: Text('Image not found')),
                        );
                      },
                    ),
                  ),
                  AppSpaces.v10,
                  Text(
                    places[index].name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  AppSpaces.v5,
                  Text(
                    places[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  AppSpaces.v15,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        context.push(DetailsScreen(place: places[index]));
                      },
                      child: const Text('Explore More'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}