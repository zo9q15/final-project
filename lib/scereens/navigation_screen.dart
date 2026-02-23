import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1 && Supabase.instance.client.auth.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<String>> _fetchExistingCities() async {
    try {
      final response = await Supabase.instance.client.from('places').select('city');
      final cities = response.map((e) => e['city'].toString()).toSet().toList();
      return cities;
    } catch (e) {
      return ['Riyadh', 'AIUIa', 'Qassim'];
    }
  }

  void _showAddPlaceModal(BuildContext context) {
    bool isNewCity = false;
    String? selectedCity;
    final newCityController = TextEditingController();
    final placeNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageUrlController = TextEditingController();
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateModal) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Tourist Place',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Existing City', style: TextStyle(fontSize: 14)),
                            value: false,
                            groupValue: isNewCity,
                            activeColor: AppColors.primary,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) => setStateModal(() => isNewCity = value!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('New City', style: TextStyle(fontSize: 14)),
                            value: true,
                            groupValue: isNewCity,
                            activeColor: AppColors.primary,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) => setStateModal(() => isNewCity = value!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (isNewCity)
                      TextField(
                        controller: newCityController,
                        decoration: const InputDecoration(
                          labelText: 'New City Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_city, color: AppColors.primary),
                        ),
                      )
                    else
                      FutureBuilder<List<String>>(
                        future: _fetchExistingCities(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final cities = snapshot.data!;
                          selectedCity ??= cities.isNotEmpty ? cities.first : null;

                          return DropdownButtonFormField<String>(
                            value: selectedCity,
                            decoration: const InputDecoration(
                              labelText: 'Select City',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                            ),
                            items: cities.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setStateModal(() {
                                selectedCity = value;
                              });
                            },
                          );
                        },
                      ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: placeNameController,
                      decoration: const InputDecoration(
                        labelText: 'Place Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.place, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: imageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Image Path/URL',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: isSaving ? null : () async {
                          final city = isNewCity ? newCityController.text : selectedCity;
                          final name = placeNameController.text;
                          final description = descriptionController.text;
                          final image = imageUrlController.text.isEmpty ? 'assets/images/placeholder.png' : imageUrlController.text;

                          if (city == null || city.isEmpty || name.isEmpty || description.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill all fields')),
                            );
                            return;
                          }

                          setStateModal(() => isSaving = true);

                          try {
                            await Supabase.instance.client.from('places').insert({
                              'city': city,
                              'name': name,
                              'description': description,
                              'main_image': image,
                            });

                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Place added successfully!')),
                              );
                              
                              setState(() {
                                _screens[0] = const HomeScreen(); 
                              });
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error adding place: $e')),
                              );
                            }
                          } finally {
                            setStateModal(() => isSaving = false);
                          }
                        },
                        child: isSaving 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Save & Add', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: const CircleBorder(),
        elevation: 4,
        onPressed: () => _showAddPlaceModal(context),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}