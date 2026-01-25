

import 'package:flutter/material.dart';

class GalleryItem {
  final String imagePath;
  final String description;

  GalleryItem({required this.imagePath, required this.description});
}

class TouristPlace {
  final String name;
  final String description;
  final String mainImage;
  final List<GalleryItem> galleryItems;

  TouristPlace({
    required this.name,
    required this.description,
    required this.mainImage,
    required this.galleryItems,
  });
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<TouristPlace> places = [
    TouristPlace(
      name: 'Riyadh City',
      description: 'Riyadh is the capital of Saudi Arabia, known for its modern architecture, historical Souq Al Zal, and the vibrant Boulevard City. It is a hub of culture and business.',
      mainImage: 'assets/images/place4.jpg',
      galleryItems: [
        GalleryItem(
            imagePath: 'assets/images/riyadh1.jpg',
            description: 'Step into the future at KAFD, where cutting-edge architecture meets world-class dining and entertainment in the heart of Riyadh.'),
        GalleryItem(
            imagePath: 'assets/images/riyadh2.jpg',
            description: 'Travel back in time at historic Diriyah. Wander through the mud-brick palaces of At-Turaif and discover the birthplace of the Saudi state.'),
        GalleryItem(
            imagePath: 'assets/images/riyadh3.jpg',
            description: 'Unleash your inner thrill-seeker at Six Flags Qiddiya. Home to record-breaking rides and immersive attractions, it is the ultimate destination for adrenaline and family fun.'),
      ],
    ),
    TouristPlace(
      name: 'AlUla City',
      description: 'AlUla is a living museum of preserved tombs and sandstone outcrops, home to Hegra, the first UNESCO World Heritage site in Saudi Arabia.',
      mainImage: 'assets/images/place5.jpg',
      galleryItems: [
        GalleryItem(
            imagePath: 'assets/images/alula1.jpg',
            description: 'Marvel at the geological wonder of Elephant Rock (Jabal AlFil). This iconic sandstone formation creates a spectacular silhouette against the golden desert sunset.'),
        GalleryItem(
            imagePath: 'assets/images/alula2.jpg',
            description: '"Explore the ancient mysteries of Hegra, Saudi Arabia’s first UNESCO World Heritage site. Admire the intricate tombs carved directly into the sandstone mountains."'),
        GalleryItem(
            imagePath: 'assets/images/alula3.jpg',
            description: 'Explore the ancient mysteries of Hegra, Saudi Arabia’s first UNESCO World Heritage site. Admire the intricate tombs carved directly into the sandstone mountains.'),
      ],
    ),
    TouristPlace(
      name: 'Qassim City',
      description: 'Qassim is the agricultural heart of the Kingdom, famous for its vast date farms, traditional festivals, and generous hospitality.',
      mainImage: 'assets/images/place6.jpg',
      galleryItems: [
        GalleryItem(
            imagePath: 'assets/images/qassim1.jpg',
            description: 'Immerse yourself in the worlds largest date market in Buraydah. Witness the vibrant auction season where millions of tons of premium dates are traded daily.'),
        GalleryItem(
            imagePath: 'assets/images/qassim2.jpg',
            description: 'Discover the heritage of legendary Arabian traders at the Aloqilat Museum. Admire the traditional mud-brick architecture and relive the history of ancient desert caravans.'),
        GalleryItem(
            imagePath: 'assets/images/qassim3.jpg',
            description: 'Gaze upon the endless green horizon of Al Rajhi Farm. Recognized as the largest date palm farm in the world, it is a breathtaking testament to Qassims agricultural abundance.'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saudi Tourist App'),
        backgroundColor: Colors.teal,
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
                      width: screenWidth,
                      height: screenWidth * 0.5,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: screenWidth * 0.5,
                          color: Colors.grey[300],
                          child: const Center(child: Text('Image not found')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    places[index].name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    places[index].description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityDetailScreen(place: places[index]),
                          ),
                        );
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

class CityDetailScreen extends StatelessWidget {
  final TouristPlace place;

  const CityDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              place.mainImage,
              width: screenWidth,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(height: 250, color: Colors.grey, child: const Icon(Icons.error)),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),

                  const Text(
                    "Photos & Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 15),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: place.galleryItems.length,
                    itemBuilder: (context, index) {
                      final item = place.galleryItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                                style: const TextStyle(fontSize: 15, color: Colors.black87),
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