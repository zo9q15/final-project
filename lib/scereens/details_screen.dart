import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tourist_place.dart';
import '../utils/app_colors.dart';
import '../utils/app_spaces.dart';

class DetailsScreen extends StatefulWidget {
  final TouristPlace place;

  const DetailsScreen({super.key, required this.place});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;
  final user = Supabase.instance.client.auth.currentUser;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    if (user == null) return;
    try {
      final response = await Supabase.instance.client
          .from('favorites')
          .select()
          .eq('user_id', user!.id)
          .eq('place_name', widget.place.name);
      if (response.isNotEmpty && mounted) {
        setState(() {
          isFavorite = true;
        });
      }
    } catch (e) {
    }
  }

  Future<void> _toggleFavorite() async {
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to add favorites')),
      );
      return;
    }

    try {
      if (isFavorite) {
        await Supabase.instance.client
            .from('favorites')
            .delete()
            .eq('user_id', user!.id)
            .eq('place_name', widget.place.name);
      } else {
        await Supabase.instance.client.from('favorites').insert({
          'user_id': user!.id,
          'place_name': widget.place.name,
        });
      }
      if (mounted) {
        setState(() {
          isFavorite = !isFavorite;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMainNetworkImage = widget.place.mainImage.startsWith('http');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : AppColors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMainNetworkImage
                ? Image.network(
                    widget.place.mainImage,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    widget.place.mainImage,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About ${widget.place.name}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  AppSpaces.v10,
                  Text(
                    widget.place.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  AppSpaces.v20,
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  AppSpaces.v10,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.place.galleryItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.place.galleryItems[index];
                      final isGalleryNetworkImage = item.imagePath.startsWith('http');

                      return Card(
                        margin: const EdgeInsets.only(bottom: 15),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8.0)),
                              child: isGalleryNetworkImage
                                  ? Image.network(
                                      item.imagePath,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
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
                                style: const TextStyle(fontSize: 15),
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