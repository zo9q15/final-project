import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tourist_place.dart';
import '../utils/app_colors.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final user = Supabase.instance.client.auth.currentUser;

  Future<List<TouristPlace>> _getFavorites() async {
    if (user == null) return [];

    final favResponse = await Supabase.instance.client
        .from('favorites')
        .select('place_name')
        .eq('user_id', user!.id);

    if (favResponse.isEmpty) return [];

    final List<String> favNames = favResponse.map<String>((e) => e['place_name'].toString()).toList();

    final placesResponse = await Supabase.instance.client.from('places').select();
    final allPlaces = placesResponse.map((json) => TouristPlace.fromJson(json)).toList();

    return allPlaces.where((place) => favNames.contains(place.name)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: FutureBuilder<List<TouristPlace>>(
        future: _getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No favorites added yet.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final places = snapshot.data!;

          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final isNetworkImage = places[index].mainImage.startsWith('http');

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: isNetworkImage
                        ? Image.network(
                            places[index].mainImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const SizedBox(width: 80, height: 80, child: Icon(Icons.broken_image)),
                          )
                        : Image.asset(
                            places[index].mainImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const SizedBox(width: 80, height: 80, child: Icon(Icons.broken_image)),
                          ),
                  ),
                  title: Text(
                    places[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.primary),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(place: places[index]),
                      ),
                    ).then((_) => setState(() {}));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}