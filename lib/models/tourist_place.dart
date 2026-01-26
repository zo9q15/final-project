class GalleryItem {
  final String imagePath;
  final String description;

  GalleryItem({required this.imagePath, required this.description});

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      imagePath: json['imagePath'],
      description: json['description'],
    );
  }
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

  factory TouristPlace.fromJson(Map<String, dynamic> json) {
    return TouristPlace(
      name: json['name'],
      description: json['description'],
      mainImage: json['mainImage'],
      galleryItems: (json['galleryItems'] as List)
          .map((item) => GalleryItem.fromJson(item))
          .toList(),
    );
  }
}