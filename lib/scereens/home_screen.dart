import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tourist_place.dart';
import '../utils/app_colors.dart';
import '../utils/app_spaces.dart';
import '../utils/extensions.dart';
import 'details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _future = Supabase.instance.client.from('places').select();
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = Supabase.instance.client.auth.currentUser;
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (mounted) {
        setState(() {
          _user = data.session?.user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saudi Tourist App'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          if (_user == null)
            TextButton.icon(
              onPressed: () {
                context.push(const LoginScreen());
              },
              icon: const Icon(Icons.login, color: AppColors.white),
              label: const Text('Login', style: TextStyle(color: AppColors.white)),
            )
          else
            IconButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
              },
              icon: const Icon(Icons.logout, color: AppColors.white),
              tooltip: 'Logout',
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tourist places added yet.'));
          }

          final data = snapshot.data!;
          final places = data.map((json) => TouristPlace.fromJson(json)).toList();

          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final isNetworkImage = places[index].mainImage.startsWith('http');

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
                        child: isNetworkImage
                            ? Image.network(
                                places[index].mainImage,
                                width: context.width,
                                height: context.width * 0.5,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: context.width * 0.5,
                                    color: Colors.grey[300],
                                    child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                                  );
                                },
                              )
                            : Image.asset(
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
          );
        },
      ),
    );
  }
}