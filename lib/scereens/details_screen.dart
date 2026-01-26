import 'package:flutter/material.dart';
import '../models/tourist_place.dart';
import '../utils/app_colors.dart';
import '../utils/app_spaces.dart';
import '../utils/extensions.dart';

class DetailsScreen extends StatelessWidget {
  final TouristPlace place;

  const DetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              place.mainImage,
              width: context.width,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                  height: 250, color: Colors.grey, child: const Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                  AppSpaces.v10,
                  Text(
                    place.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  AppSpaces.v20,
                  const Divider(),
                  AppSpaces.v10,
                  const Text(
                    "Photos & Details",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                  AppSpaces.v15,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: place.galleryItems.length,
                    itemBuilder: (context, index) {
                      final item = place.galleryItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.asset(
                                item.imagePath,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                item.description,
                                style: const TextStyle(
                                    fontSize: 15, color: AppColors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}